<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 12/24/16
 * Time: 11:58 AM
 */

namespace App\Http\Controllers;

use App\Libs\AuthToken;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeController extends Controller
{


    /**
     * HomeController constructor.
     */
    public function __construct()
    {
    }

    public function notification(Request $request)
    {
        return $this->returnResponse();
    }

    public function getHistoryMessage(Request $request)
    {
        $this->validate($request, [
            'peer' => 'required|min:4|max:191',
            'take' => 'numeric|min:1|max:100',
            'skip' => 'numeric|min:0'
        ]);
        try {
            $take = ($request->input('take') == null) ? 10 : $request->input('take');
            $skip = ($request->input('skip') == null) ? 0 : $request->input('skip');

            try {
                list($peer, $host) = explode("@", $request->input('peer'));
            } catch (Exception $e) {
                $peer = $request->input('peer');
            }

            $message = DB::table('archive')->where([
                ['username', '=', AuthToken::getToken()->getId()],
                ['peer', 'like', $peer . '%']
            ])->skip($skip)->take($take)->get();
            if ($message != null) {
                $this->response['code'] = OK;
                $this->response['data'] = $message;
            } else {
                $this->response['code'] = NOT_FOUND;
            }
        } catch (Exception $e) {
            $this->response['code'] = ERROR;
            $this->response['data'] = $e->getMessage();
        }
        return $this->returnResponse();
    }

    public function getLastMessage(Request $request)
    {
        $this->validate($request, [
            'peer' => 'required|min:4|max:191',
            'take' => 'numeric|min:1|max:100',
            'skip' => 'numeric|min:0'
        ]);
        try {
            $take = ($request->input('take') == null) ? 10 : $request->input('take');
            $skip = ($request->input('skip') == null) ? 0 : $request->input('skip');

            try {
                list($peer, $host) = explode("@", $request->input('peer'));
            } catch (Exception $e) {
                $peer = $request->input('peer');
            }

            $message = DB::table('last_message')
                ->select('txt', 'update_time')
                ->where([
                    ['username', '=', AuthToken::getToken()->getId()],
                    ['peer', 'like', $peer . '%']
                ])->skip($skip)->take($take)->first();

            if ($message != null) {
                $this->response['code'] = OK;
                $this->response['data'] = $message;
            } else {
                $this->response['code'] = NOT_FOUND;
            }
        } catch (Exception $e) {
            $this->response['code'] = ERROR;
            $this->response['data'] = $e->getMessage();
        }
        return $this->returnResponse();
    }
}