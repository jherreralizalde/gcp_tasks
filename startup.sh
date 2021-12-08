!/bin/bash
echo 'test' > /test.txt
apt-get update -y
apt-get install cowsay -y
apt-get install aptitude -y
apt update
 apt -y install apache2
  cat <<EOF > /var/www/html/index.html
 <html><body><p>Linux startup script added directly.</p></body></html>
