# swoole-docker
Servidor swoole php + lumen +docker em 5 minutos.
[Swoole docs](https://www.swoole.co.uk/docs/)
## Por que usar?
Uma leitura [rapida](https://morettic.com.br/wp2/swoole-php-extensao/)

# Intalação
Necessário que ja tenham  `composer`, `git` e `docker descktop` instalados.

* Clonando arquivos do docker para intalação do container
```shell
$ git clone https://github.com/angularbr/swoole-docker.git 

```
* Instalalndo Lumen microframeworks
```
$ cd swoole-docker
$ composer create-project --prefer-dist laravel/lumen my-project
```
### Adicionar o pacote `laravel-swoole` com o composer:
```
$ composer require swooletw/laravel-swoole
```
### Em seguida, adicione o provedor de serviços:
Anexe a seguinte linha a `bootstrap/app.php`:
```php
$ app->register( SwooleTW\Http\LumenServiceProvider::class );
```
* Criando a imagen e container no docker.
```shell
$ docker build  --build-arg appname="my-project" -t "swoole-lumen:server" .
```
Observe que a ENV:`appname` deve ser o nome da pasta do projeto criado com `composer create-project`
* Rodando container 
```shell
$ docker run -d -p 3000:80 --name s-server swoole-lumen:dev
```
Nessa linha, rodamos o container na porta `3000`, o argumento `--name` é muito importante este e nome do container, precisamos disso para que possamos executar `artisan` dentro do container.
* Pronto, executado swoole server, note que podemos acessar tanto `php` quanto o `artisan` dentro do container (`s-server`).
 ```shell
$ docker exec s-server php artisan swoole:http start
```
 1) Restart swoole
```shell
$ docker exec s-server php artisan swoole:http restart
```
2) Usando o `artisan`
```shell
$ docker exec s-server php artisan --version
```
