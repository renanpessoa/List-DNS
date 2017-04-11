####  **`English`**

## About

This script will list all DNS of the server's domains, from a reseller or file.

#### **`Only for cPanel/WHM servers`**

## Options

    -h, --help
        displays options

    -a, --all
        List all DNS of the server's domains

    -r, --reseller
        List all DNS of a reseller's domains

    -f, --file
        List all domains's DNS from a file


Tips
-------------

Please, see the below tips for a better use of the script.

* List domains that are still pointing to the old server after migration.
<pre>
./listdns -[option] | grep [old server IP]
</pre>

* List domains that aren't using the reseller's custom DNS. [Ex: ns1.resellerdomain.com]
<pre>
./listdns -[option] | grep -v [custom DNS]
</pre>

* List domains that aren't pointing to an IP [Ex: freezed domain ]
<pre>
./listdns -[option] | grep "IP:  " 
</pre>


<br>

####  **`Português`**

## Sobre
Esse script tem a finalidade de listar o apontamento de DNS dos domínios do servidor, de uma revenda ou a partir de uma lista. 

#### **`Este script funciona apenas em servidores cPanel/WHM`**

## Opções disponíveis

    -h, --help
        exibe as opções disponíveis
            
    -a, --all
        Lista o DNS de todos os domínios do servidor
    
    -r, --reseller
        Lista o DNS de todos os domínios de uma revenda
            
    -f, --file
        Lista o DNS dos domínios a partir de um arquivo

Dicas de utilização
-------------

Para um melhor aproveitamento do script, segue abaixo algumas dicas de utilização:

* Listar os domínios que ainda apontam para o servidor antigo após a migração
<pre>
./listdns -[opção] | grep [ip do antigo servidor]
</pre>

* Listar domínios que não utilizam DNS personalizado do revendedor [Ex: ns1.domain.com]
<pre>
./listdns -[opção] | grep -v [dns personalizado do revendedor]
</pre>

* Listar domínios que não apontam para um IP [Ex: Domínio congelado]
<pre>
./listdns -[opção] | grep "IP:  "
</pre>
