cat /etc/systemd/system/joy.service
apt-get install ufw
echo "PLS enter validator Name"
read name
rm joy-testnet-4.json*
wget https://github.com/Joystream/joystream/releases/download/v7.5.0/joystream-node-3.3.0-fdb75f5ec-x86_64-linux-gnu.tar.gz
tar -vxf joystream-node-3.3.0-fdb75f5ec-x86_64-linux-gnu.tar.gz
wget https://github.com/Joystream/joystream/releases/download/v7.5.0/joy-testnet-4.json
ufw allow 300000
ufw allow 1200
ufw allow 1201
ufw allow 22
systemctl stop joy
cat <<EOF > /etc/systemd/system/joy.service

[Unit]
Description=Joystream Node
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/
ExecStart=/root/joystream-node \
        --chain joy-testnet-4.json \
        --pruning archive \
        --validator \
        --name $name \
        --port 30000 \
        --rpc-port 1200 \
        --ws-port 1201 
Restart=on-failure
RestartSec=3
LimitNOFILE=8192

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start joy
