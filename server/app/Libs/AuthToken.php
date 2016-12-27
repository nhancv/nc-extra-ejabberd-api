<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 12/27/16
 * Time: 10:14 AM
 */

namespace App\Libs;

use App\Model\Token;
use Illuminate\Support\Facades\DB;

class AuthToken
{
    private static $token;

    /**
     * @return mixed
     */
    public static function getToken()
    {
        return self::$token;
    }

    /**
     * @param mixed $token
     */
    public static function setToken(Token $token)
    {
        self::$token = $token;
    }

    public static function updateToken($token)
    {
        list($user, $pass) = explode(":", base64_decode($token));
        $userAuthentication = DB::table('users')->where([
            ['username', '=', $user],
            ['password', '=', $pass]
        ])->first();
        if ($userAuthentication != null) {
            self::setToken(new Token($user, time()));
            return self::getToken();
        } else {
            return null;
        }
    }

}