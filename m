Reply-To: <fred@sc23.sc.mcel.mot.com>
From: "fred" <fred@sc23.sc.mcel.mot.com>
To: "'Ing.Gianfranco Morandi'" <gianfranco.morandi@euro-studio.it>,
	"LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: respawning too fast
Date: Sat, 26 Oct 2002 15:44:35 +0800
Message-ID: <000001c27cc3$8840f2e0$940879c8@sc.mcel.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <007c01c27c08$d9bb2b60$0700a8c0@pc005>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is there a proper define of /dev/console?

-----Original Message-----
From: Ing.Gianfranco Morandi [mailto:gianfranco.morandi@euro-studio.it]
Sent: Friday, October 25, 2002 5:28 PM
To: LinuxPPC
Subject: respawning too fast


Finally I have solved the starting problem on my EST8260 board. I have
burned the flash with the PPCboot 1.20 and I've been able to load any
kernel: M.V. 2.4.2 and ELDK 2.4.4.
Now I was trying to go ahead with a newer version of kernel (i.e. 2.4.18)
and now this is what happens:


BOOTP broadcast 1
ARP broadcast 1
TFTP from server 10.0.0.10; our IP address is 10.0.0.20
Filename '/tftpboot/image'.
Load address: 0x500000
Loading: #################################################################
         ###############################
done
Bytes transferred = 491392 (77f80 hex)
## Booting image at 00500000 ...
   Image Name:   FEC-Linux 2.4.18
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    491328 Bytes = 479.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
..................
..................
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 10.0.0.10, my address is 10.0.0.20
IP-Config: Complete:
      device=eth0, addr=10.0.0.20, mask=255.0.0.0, gw=255.255.255.255,
     host=10.0.0.20, domain=, nis-domain=(none),
     bootserver=10.0.0.10, rootserver=10.0.0.10, rootpath=/opt/eldk/ppc_82xx
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.10
Looking up port of RPC 100005/1 on 10.0.0.10
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 52k init
tty_io.c: process 1 (swapper) used obsolete /dev/cua - update software to
use /d
ev/ttyS0
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use
/dev/
ttyS0
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use
/dev/
ttyS0
INIT: tty_io.c: process 1 (init) used obsolete /dev/cua - update software to
use
 /dev/ttyS0
version 2.78 bootingtty_io.c: process 1 (init) used obsolete /dev/cua -
update s
oftware to use /dev/ttyS0
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access
method.
Setting clock : Wed Dec 31 19:00:07 EST 1969 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname 10.0.0.20:  [  OK  ]
Checking filesystems
Checking all file systems.
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting xinetd: [  OK  ]
INIT: Id "3" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel

I don't understand the messages related to the /dev/cua (these messages were
not present with the ELDK) and why the INIT process doesn't let me get the
console prompt.

Any suggestions?

Thanks
Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
