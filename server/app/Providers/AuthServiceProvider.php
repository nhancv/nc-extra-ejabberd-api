<?php

namespace App\Providers;

use App\Libs\AuthToken;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Boot the authentication services for the application.
     *
     * @return void
     */
    public function boot()
    {
        // Here you may define how you wish users to be authenticated for your Lumen
        // application. The callback which receives the incoming request instance
        // should return either a User instance or null. You're free to obtain
        // the User instance via an API token or any other method necessary.

        $this->app['auth']->viaRequest('api', function (Request $request) {
            try {
                if ($request->hasHeader("Authorization")) {
                    $bearer = $request->header("Authorization");
                    $bearer_code = 'Basic ';
                    if (strpos($bearer, $bearer_code) !== false) {
                        $token = substr($request->header("Authorization"), strlen($bearer_code));
                        return AuthToken::updateToken($token);
                    }
                } else if ($request->has('api_token')) {
                    return AuthToken::updateToken($request->input('api_token'));
                }
            } catch (Exception $e) {
            }
            return null;
        });
    }
}
