<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 12/24/16
 * Time: 11:58 AM
 */

namespace App\Http\Controllers;

use App\Libs\AuthToken;
use App\Libs\HeaderResponse;
use App\Libs\Util;
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
        try {
            //@nhancv TODO: send mail
            ob_start();
            HeaderResponse::closeHeader();

            $this->response['code'] = OK;
            echo json_encode($this->response);
            header('Connection: close');
            header('Content-Length: ' . ob_get_length());
            ob_end_flush();
            ob_flush();
            flush();

            $html_body = '<p>_From: ' . $request->input('From')
                . '<br>_To: ' . $request->input('To')
                . '<br>_Body: ' . $request->input('Body')
                . '</p>_XML: <textarea>' . $request->input('XML') . '</textarea>';
            Util::sendEmail('caovannhan2002@gmail.com', 'Test xmpp notification', $html_body);
        } catch (Exception $e) {
            $this->response['code'] = ERROR;
            $this->response['data'] = $e->getMessage();
        }
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