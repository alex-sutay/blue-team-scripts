#!/bin/bash

# Define the list of allowed ports
allowed_ports=("22" "80" "443")  # Add your desired ports to this list

# Define the IP address range to block
start_ip="10.0.6.0"
end_ip="10.0.255.255"

# Generate a random port number (between 1024 and 65535)
random_port=$((RANDOM % (65535-1024+1) + 1024))

# Reset UFW to its default settings
ufw --force reset

# Set the default policy to allow incoming traffic (to follow the rules)
ufw default allow incoming

# Deny all incoming traffic on all ports
for port in {1..65535}; do
    if ! [[ "${allowed_ports[*]}" =~ "$port" || "$port" == "$random_port" ]]; then
        ufw deny "$port"
    fi
done

# Block incoming traffic from the specified IP address range
for net in {6..255}; do
    for ip in $(seq -f "10.0.$net.%g" 0 255); do
        ufw deny from "$ip" to any
    done
done

# Enable the firewall
ufw enable

echo "UFW rules have been configured to allow ports: ${allowed_ports[*]} and a random port: $random_port, and deny all other incoming traffic. Traffic from IP range $start_ip to $end_ip is also blocked."
