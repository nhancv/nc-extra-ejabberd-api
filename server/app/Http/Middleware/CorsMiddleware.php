<?php

namespace App\Http\Middleware;

use App\Libs\HeaderResponse;
use Closure;

class CorsMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \Closure $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        return HeaderResponse::normalHeader($next($request));
    }
}
