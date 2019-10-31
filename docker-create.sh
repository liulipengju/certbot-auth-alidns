# 首先关闭当前运行的nginx
systemctl stop nginx

EMAIL=您的邮箱地址
OUTPUT_DIR=letsencrypt
if [ -d "$OUTPUT_DIR" ]
then
   echo ""
else
   mkdir $OUTPUT_DIR
fi

echo "Create LetsEncrypt certificate..."
echo "域名："$DOMAIN




if [ "$#" -eq  "1" ]
then
    DOMAIN=$1
else
    echo "Please enter your domain name (e.g. example.org): "
    read DOMAIN
fi


echo "Create LetsEncrypt certificate..."
#mkdir letsencrypt
docker run -it --rm -p 443:443 -p 80:80 -v $PWD/letsencrypt:/etc/letsencrypt/ certbot/certbot certonly --standalone --noninteractive  --email $EMAIL --agree-tos -d $DOMAIN
docker run -it --rm -v $PWD/letsencrypt/live/:/certificates/ lesspass/openssl openssl dhparam -out /certificates/$DOMAIN/dhparam.pem 4096


echo "--------------------------------------------"
echo "Congratulation is done!"
echo "--------------------------------------------"
echo "visit https://$DOMAIN"
echo

# 启动当前系统运行的nginx
system start nginx
