<?php
$app->options('{all:.*}', ['middleware' => 'cors', function () {
    return response('');
}]);

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$app->get('/', ['middleware' => 'auth', function () use ($app) {
    return $app->version();
}]);

//Home
$app->post('/message/history', ['middleware' => 'auth', 'uses' => 'HomeController@getHistoryMessage']);
$app->post('/message/last', ['middleware' => 'auth', 'uses' => 'HomeController@getLastMessage']);
$app->post('/notification', 'HomeController@notification');

