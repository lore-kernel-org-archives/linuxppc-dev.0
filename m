From: kd@flaga.is
Subject: CPM_ENET
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFEA02D635.86F21A0E-ON00256952.004361C4@flaga.is>
Date: Wed, 6 Sep 2000 12:22:25 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am wondering......

Why is the ehternet device (arch/ppc/8xx_io/enet.c) of the MPC8xx linux
kernel refered to as CPM_ENET but not as eth0 from user space programs?

E.g. if I use ip to set the device up I have to give a command like......
ip link set CPM_ENET up
instead of
ip link set eth0 up

and so on.

I would think that the CPM_ENET device is the eth0 of the MPC823 and can
therfore be called eth0..... but then again I am just learning the ways of
the Linux kernel 8-).


K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
