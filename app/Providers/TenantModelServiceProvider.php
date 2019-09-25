<?php

namespace App\Providers;

use Illuminate\Support\Facades\Config;
use Illuminate\Support\ServiceProvider;

class TenantModelServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        // this is what the config.php for each tenant looks like
        // return = [
        //     'models'=>[
        //         'TenantModel1'=>'TenantModel2',
        //     ]
        // ];

        // Use
        // Helper function:
        // $this->bindTenantModel('TenantModel1');
        // Or:

        $this->app->bind(
            'TenantModel1',
            function($app){
                $model = Config::get('models.TenantModel1'); // should be retrived from config

                if($model){ // if this tenant has model binding configuration
                    return new $model();
                } else {
                    return new App\TenantModel1();
                }
            }
        );


    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    // public function bindTenantModel($modelName)
    // {
    //     $this->app->bind(
    //         "$modelName",
    //         function($app) use($modelName){
    //             $model = Config::get("models.$modelName"); // should be retrived from config

    //             if($model){ // if this tenant has model binding configuration
    //                 return new $model();
    //             } else {
    //                 $modelNameSpace = 'App\\'.$modelName;
    //                 return new $modelNameSpace();
    //             }
    //         }
    //     );
    // }
}
