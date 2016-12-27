<?php

namespace App\Http\Controllers;

use App\Libs\HeaderResponse;
use Laravel\Lumen\Routing\Controller as BaseController;

define("OK", 200);
define("ERROR", 201);
define("UN_KNOW", 203);
define("NO_CONTENT", 204);
define("NOT_FOUND", 404);
define("CONFLICT", 409);

class Controller extends BaseController
{
    public $response = array();

    public function returnResponse()
    {
        return HeaderResponse::normalHeader(response($this->response));
    }

    public function returnMobileResponse()
    {
        return HeaderResponse::mobileHeader(response($this->response));
    }

    public function returnWebResponse()
    {
        return HeaderResponse::webHeader(response($this->response));
    }
}
