#!/bin/bash

# Author: Renan Pessoa / renanhpessoa@gmail.com
# Date: 30/Setembro/2016
# Version: 1.0

#. Install whois .#
whois --version &> /dev/null
[[ `echo $?` != 0 ]] && yum -y install jwhois &> /dev/null

whois --version &> /dev/null
[[ `echo $?` != 0 ]] && yum -y install whois &> /dev/null

message()
{

echo -e "
USAGE 
\tlistdns [OPTION] [RESELLER/FILE]
  
OPTIONS
\t-h, --help
\t\tdisplays options

\t-a, --all
\t\tList all DNS of the server's domains

\t-r, --reseller
\t\tList all DNS of a reseller's domains

\t-f, --file
\t\tList all domains's DNS from a file"

}

#. if not passed any option .#
if [[ -z "$1" ]];then
  message;
  exit;
fi

func_exec()
{
  echo -e "Domain: $domain  IP: `host $domain | grep address | awk '{print $4}' | xargs -n6`  DNS: ` whois $domain| grep -i server | cut -d: -f2 | grep -iv "whois" | tr [:upper:] [:lower:] | xargs -n6`"; 
}

case $1 in

  #. help option .#
  --help|-h) message;exit;;

  #. all domains of server .#
  -a|--all ) 
  { 
    for domain in `cat /etc/trueuserdomains | egrep -v "\*|\#" | cut -d: -f1 `;do
      func_exec;
    done;
  };;

  #. domains of reseller .#
  -r|--reseller ) 
  {
    if [ -z $2 ]; then
          read -p "Inform the reseller username: " account;
        else
          account=$2
      fi

      if [[ -z "$account" ]] ;then
          echo -e "\nWhite space? Type a valid reseller. \n";
          exit;
      fi

      if [[ -e /var/cpanel/users/$account ]];then

          if [[ $account != $(grep -i -s owner /var/cpanel/users/$account | cut -d= -f2) ]];then

            echo -e "\nThe account '$account' exists, but it is not a reseller :/";
            exit;
          fi

        else
        
          echo -e "\nThe Account informed does not exist or could not be found.";
          exit;
      fi
    
    for i in `grep $account /etc/trueuserowners | cut -d: -f1`;do
        
      domain=$(grep -w $i /etc/trueuserdomains | cut -d ':' -f1);
      func_exec;
    done;
  };;

  #. domains from a file .#
  -f|--file ) 
  {
    if [ -z $2 ]; then
          echo -e "Its necessary to inform the file which contain the domains list."
            exit;
      fi
          
    _file=$2;

      if [[ -f "$_file" ]] && [[ ! -z `cat $_file 2>/dev/null | grep -v ^$ ` ]] ;then

        for i in `cat $_file 2>/dev/null`;do
          
        domain=$(echo $i | grep -s "\." );
          
        if [[ -z $domain ]];then
          erro+=(" $i ");
          continue;
        fi

        func_exec;
      
      done;

      if [[ ! -z $erro ]];then
        echo -e "\nThe below values contained in the file are not valid domains:"
        echo -e "-------------------------------------------------"
        echo -e "${erro[@]}" | xargs -n1;
        echo -e "-------------------------------------------------"
      fi

        else
        
          echo -e "The specified file does not exist or is empty.";
          exit;
      fi

  };;

  *) message;exit;;
esac
