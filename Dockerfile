FROM rockylinux:9.3

RUN dnf update -y && \ 
dnf install epel-release -y && \
dnf install ansible openssh-server passwd sudo -y && \
dnf clean all

RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN useradd ansible-user

RUN echo 'ansible-user:1234' | chpasswd

RUN touch /etc/sudoers.d/ansible

RUN echo "ansible-user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
