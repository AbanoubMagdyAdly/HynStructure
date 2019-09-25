<?php

namespace App;

class TenantModel1 implements ITenantModel
{
    public function __construct() {
    }
    public static function who() {
        dd(self::class);
    }
}
