<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 10/22/16
 * Time: 5:42 AM
 */

namespace App\Jobs;


use App\Libs\AesCrypt;
use App\Model\Token;
use Exception;
use Firebase\JWT\JWT;

class JWTAuth
{
    private $key;
    private $expire = 24 * 60 * 60; //24 hours

    /**
     * JWTAuth constructor.
     */
    public function __construct()
    {
        $this->key = (new AesCrypt())->aesDecrypt(128, env('JWT_ENCRYPT', ""), env('JWT_KEY', ""));
    }

    public function getToken($id)
    {
        $token = array(
            "id" => $id,
            "create" => time()
        );
        return JWT::encode($token, $this->key);
    }

    public function decodeToken($jwt)
    {
        JWT::$leeway = 60;
        return JWT::decode($jwt, $this->key, array('HS256'));
    }

    public function verifyToken($jwt)
    {
        try {
            JWT::$leeway = 60;
            $decode = JWT::decode($jwt, $this->key, array('HS256'));
            $isExpire = time() - $decode->create;
            if ($isExpire >= 0 && $isExpire <= $this->expire) {
                return new Token($decode->id, $decode->create);
            }
        } catch (Exception $e) {
            return null;
        }
    }
}