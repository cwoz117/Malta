iptables -I DOCKER-USER -i ext_if ! -s 10.0.0.0/24 -j DROP

sh -c "iptables-save > /etc/iptables.rules"
