Message-ID: <3C1A006C.9060201@gatekeeper.informatik.fh-dortmund.de>
Date: Fri, 14 Dec 2001 14:36:44 +0100
From: Ralf Weidemann <linuxppc@gatekeeper.informatik.fh-dortmund.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.17-pre8-ben0: should pcmcia work ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I installed the kernel-pcmcia-cs (3.1.27-10b) package from YDL 2.1 and tried
to set the "PCIC" option in /etc/sysconfig/pcmcia to "tcic" and "i82365", but
both did not work on my tibook. Must I use another socket driver or is some-
thing broken ?

Thanks
Ralf

[root@tibook /root]# cat /etc/sysconfig/pcmcia
PCMCIA=yes
PCIC=tcic
PCIC_OPTS=do_scan=0
CORE_OPTS=
CARDMGR_OPTS=-f

[root@tibook /root]# cat /proc/cpuinfo
cpu
	: 7410, altivec supported
temperature 	: 51-53 C (uncalibrated)
clock
	: 500MHz
revision
: 17.3 (pvr 800c 1103)
bogomips
: 996.14
machine
	: PowerBook3,2
motherboard
: PowerBook3,2 MacRISC2 MacRISC Power Macintosh
L2 cache	: 1024K unified
memory
	: 512MB
pmac-generation
: NewWorld


[root@tibook /root]# /etc/init.d/pcmcia start
Starting PCMCIA services: modules/lib/modules/2.4.17-pre8-ben0/pcmcia/i82365.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ
parameters
/lib/modules/2.4.17-pre8-ben0/pcmcia/ds.o: init_module: Operation not permitted
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ
parameters
  cardmgr.


[root@tibook /root]# /etc/init.d/pcmcia start
Starting PCMCIA services: modules/lib/modules/2.4.17-pre8-ben0/pcmcia/tcic.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ
parameters
/lib/modules/2.4.17-pre8-ben0/pcmcia/ds.o: init_module: Operation not permitted
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ
parameters
  cardmgr.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
