env delete bootargs
setenv bootargs "earlyprintk console=ttyAMA0,115200,ttyS0 init=/init"
setenv serverip 192.168.50.9
setenv httpdstp 8080
dhcp
wget ${kernel_addr_r} /image.fit
bootm
