echo "PLS enter validator Name"
read name

wget https://github.com/Joystream/joystream/releases/download/v7.5.0/joystream-node-3.3.0-fdb75f5ec-x86_64-linux-gnu.tar.gz
tar -vxf joystream-node-3.3.0-fdb75f5ec-x86_64-linux-gnu.tar.gz
wget https://github.com/Joystream/joystream/releases/download/v7.5.0/joy-testnet-4.json

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
        --wasm-execution Compiled \
        --name $name
Restart=on-failure
RestartSec=3
LimitNOFILE=8192

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start joy
