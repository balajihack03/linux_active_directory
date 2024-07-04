#/bin/bash
pkg_install(){
    sudo apt update -y
    sudo apt install realmd -y
}
dns_update(){
    #sudo rm -rf /etc/resolv.conf
    #sudo touch /etc/resolv.conf
    sudo bash -c 'echo "nameserver $Domainname" > /etc/resolv.conf.tmp'
    sudo mv /etc/resolv.conf.tmp /etc/resolv.conf
    }
check_domain(){
    sudo realm discover $domain
}
user_add(){
    echo 'Enter Domain control Password'
    sudo realm join -U $username $domain -P $domain_password
}
echo 'Enter your root user password:'
pkg_install
read -p 'Enter your Domain server IP' $Domainname
dns_update
read -p 'Enter you Domain Name (ex example.com):' domain
read -p 'Enter you Domain control username:' username
read -s -p 'Enter Domain Control Password: ' domain_password
sudo pam-auth-update
check_domain
user_add
sudo systemctl restart sssd