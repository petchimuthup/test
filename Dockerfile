# Base image (can be any lightweight base like Alpine, Ubuntu, etc.)
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update -y && apt-get install -y openssh-server sudo

# Create a user for SSH access (avoid root login)
RUN useradd -ms /bin/bash ansuser && echo "ansuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set up SSH directory and authorized_keys for the user
RUN mkdir -p /home/ansuser/.ssh && chown ansuser:ansuser /home/ansuser/.ssh

# Copy public key to the authorized_keys (you need to have the public key prepared)
COPY id_rsa.pub /home/ansuser/.ssh/authorized_keys

# Set correct permissions
RUN chmod 700 /home/ansuser/.ssh && chmod 600 /home/ansuser/.ssh/authorized_keys

# Configure SSH daemon
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
    
RUN mkdir -p /var/run/sshd

RUN chmod 0755 /var/run/sshd

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

