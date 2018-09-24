/*
* Go Library (C) 2017 Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
* @project     Ukkbox
* @package     main
* @author      @jeffotoni
* @size        21/08/2017
*
 */

package route

import (
	"context"
	"github.com/didip/tollbooth"
	cors "github.com/jeffotoni/fileserver/pkg/cors"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"time"
)

//
// add context
//
func AddContext(next http.Handler) http.Handler {

	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

		// /v1/file/be02ca7e58fbbc4158415d636662872ec3e64cfd
		vetorUrl := ReverseString(strings.Split(r.RequestURI, "/"))
		var IdUrl, newUrl string

		// limiter := tollbooth.NewLimiter(NewLimiter, time.Second, nil)

		// seria o id
		if vetorUrl[0] != "" {

			IdUrl = vetorUrl[0]
			vetorUrl[0] = ""
			newUrl = strings.Join(ReverseString(vetorUrl), "/")

			if newUrl != "/v1/file/" {

				IdUrl = "" // remove
			}
		}

		log.Println(newUrl)

		// cookie, _ := r.Cookie("IdUrl")

		if IdUrl != "" {

			log.Println(IdUrl)

			//Add data to context
			ctx := context.WithValue(r.Context(), "id", IdUrl)

			if ValidateHandler(w, r) {

				MethodUploadRemoveDefinitive(w, r.WithContext(ctx))

			} else {

				HandlerError(w, r)
			}

			// tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodUploadRemoveDefinitive))
			// next.ServeHTTP(w, r.WithContext(ctx))

		} else {

			next.ServeHTTP(w, r)
		}
	})
}

//
//
//
func Handlers() {

	/**
	*
	Types of handlers authentication:

	1 => AuthBasicKey

	This method will validate the header containing the X-key, this key is generated in the application that server the front-end, html application and js.
	The key is an algorithm available from the api itself to talk to each other.
	Every request from the public part of the site will come to this key.
	It can be a temporary key or not.

	Affected Methods

	/create/user
	/set/password
	/login

	2 => AuthBasicJwt

	This method will validate the X-Key header and the login and password from a form of application / x-www-form-urlencoded or application / json
	Validation will be done in the login database and password, which will work fine, the system generates a token with an expiration date that is sent to the user.
	The user will receive the access token and the expiration date.
	With this token the user can access all the handlers of the admin environment, that is after login.

	Affected Methods

	/login

	3 => AuthBasicHandler

	This method is responsible for validating internal or logged in handlers

	/hello
	/logout
	/upload
	/download

	/file/remove
	/file/remove/trash

	/super/file/remove
	/super/file/remove/trash

	/confirm/email

	/create/user

	/disable/user
	/super/remove/user

	/close/account
	/restore/account

	/update/profile
	/update/password
	/update/email
	/update/avatar

	The Ping method is the only open method, it does not need any type of authentication, it is to perform tests in the Availability API.
	It has a rate limit of access per second like all methods.

	*/

	// Creating limiter for all handlers
	// or one for each handler. Your choice.
	// This limiter basically says: allow at most NewLimiter request per 1 second.
	//
	// or create a limiter with expirable token buckets
	// This setting means:
	// create a 1 request/second limiter and
	// every token bucket in it will expire 1 hour after it was initially set.
	// &limiter.ExpirableOptions{DefaultExpirationTTL: time.Hour}
	limiter := tollbooth.NewLimiter(NewLimiter, time.Second, nil)

	limiter.SetIPLookups([]string{"RemoteAddr", "X-Forwarded-For", "X-Real-IP"}).
		SetMethods([]string{"GET", "POST"})
	// Limit only GET and POST requests.
	//limiter.Methods = []string{"GET", "POST"}

	//
	//
	//
	mux := http.NewServeMux()

	//
	// defining Cors that can access our system
	// even though they are not being managed by the api or outside the domain
	corsx := cors.New(cors.Options{

		AllowedOrigins:   CorsAllow,
		AllowedMethods:   CorsAllowedMethods,
		AllowedHeaders:   CorsAllowedHeaders,
		AllowCredentials: true,
	})

	// contextedMux := AddContext(mux)

	// cors allow
	cors.AllowAll().Handler(mux)

	// cors mux
	handlerCors := corsx.Handler(mux)

	// handlerCors := corsx.Handler(contextedMux)

	// only an escape to test upload submissions
	// being served by the API itself
	exampleHtml := UkkGwd("example", 2)
	exampleHtmlCss := exampleHtml + "css"
	mux.Handle("/example/", http.StripPrefix("/example/", http.FileServer(http.Dir(exampleHtml))))
	mux.Handle("/example/css", http.StripPrefix("/example/css", http.FileServer(http.Dir(exampleHtmlCss))))

	apidocHtml := UkkGwd("apidoc", 2)
	mux.Handle("/apidoc/", http.StripPrefix("/apidoc/", http.FileServer(http.Dir(apidocHtml))))

	//
	// Test api width ping
	// Public widthout X-Key
	//
	mux.Handle(HandlerPing, tollbooth.LimitFuncHandler(limiter, MethodPing))

	//
	// Off the default mux
	// Does not need authentication, only user key and token
	// public / generate jwt
	//
	mux.Handle(HandlerLogin, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(AuthBasicJwt, MethodLogin)))

	//
	// Public
	// Width X-Key
	//
	mux.Handle(HandlerCreateUser, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(AuthBasicKey, MethodCreateUser)))

	//
	//
	//
	mux.Handle(HandlerConfirmEmail, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(GetAuthBasicKey, MethodConfirmEmail)))

	//
	// Private
	// Test the api using the access keys
	// ValidHandler
	mux.Handle(HandlerHello, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodHello)))

	//
	// Private
	// Upload files
	// ValidHandler
	mux.Handle(HandlerUpload, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodUpload)))

	//
	// this handler is the base arrow warning that the file has been deleted
	// only logically, ie at this time it is only viewed in the bin
	mux.Handle(HandlerUploadRemoveDefinitive, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodUploadRemoveDefinitive)))
	// mux.HandleFunc(HandlerUploadRemoveDefinitive, MethodUploadRemoveDefinitive)

	//
	// this handler warns the system to remove from the bin and physically from the system, there will
	// be an agent responsible for cleaning the physical files and removing the database
	mux.Handle(HandlerUploadRemoveFileTrash, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodUploadRemoveFileTrash)))

	//the user of the token itself will be able to authenticate and the parameter to be passed is the
	//email and key of the user, the key is an encrypted key generated at the moment of creation
	//of the user in this way it will be possible to close the account
	mux.Handle(HandlerCloseAccount, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodCloseAccount)))

	// this method will open and serve a html page to restore the user account, the request will
	// come from the email most of the time.
	mux.Handle(HandlerRestoreAccount, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(GetAuthBasicKeyRestoreAccount, MethodRestoreAccount)))

	//
	//
	//
	mux.Handle(HandlerDisableUser, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodDisableUser)))

	//
	//
	//
	mux.Handle(HandlerEnableUser, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodEnableUser)))

	//
	//
	//
	mux.Handle(HandlerDownload, tollbooth.LimitFuncHandler(limiter, HandlerFuncAuth(ValidateHandler, MethodDownload)))

	//
	//
	//
	confServer = &http.Server{

		Addr: ":" + ServerPort,

		Handler: handlerCors,
		//ReadTimeout:    30 * time.Second,
		//WriteTimeout:   20 * time.Second,
		MaxHeaderBytes: MaxHeaderByte, // Size accepted by package
	}

	//
	//
	//
	go func() {

		// service connections
		if err := confServer.ListenAndServe(); err != nil {
			log.Printf("listen: %s\n", err)

		}
	}()

	// Wait for interrupt signal to gracefully shutdown the server with
	// a timeout of 5 seconds.
	quit := make(chan os.Signal)
	signal.Notify(quit, os.Interrupt)
	<-quit
	log.Println("Shutdown Server ...")

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	if err := confServer.Shutdown(ctx); err != nil {

		log.Fatal("Server Shutdown:", err)
	}

	log.Println("Server exist")

	log.Fatal(confServer.ListenAndServe())

}
