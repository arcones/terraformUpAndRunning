#!/bin/bash

cat > index.html << EOF
<h1>Hello, I am Marta Arcones</h1><br>
<h2>Software Engineer</h2><br>
<p>DB address: ${db_address}</p><br>
<p>DB port: ${db_port}</p><br>
EOF

nohup busybox httpd -f -p "${server_port}"" &