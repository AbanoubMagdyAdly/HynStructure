<?php

namespace App;


class TenantModel2 implements ITenantModel
{
    public function __construct() {
    }
    public static function who() {
        dd(self::class);
    }
}
