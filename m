Message-ID: <3D6C2789.B5DDFB70@redswitch.com>
Date: Tue, 27 Aug 2002 18:29:46 -0700
From: Jin Cheng <jcheng@redswitch.com>
MIME-Version: 1.0
To: Aman <aman@mistralsoftware.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Downloading Image
References: <3D6BB90D.FEA66532@redswitch.com> <001c01c24df2$76195030$370da8c0@aman>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I used ELDK ppc_4xx toolchain to compile a kernel from the same source as Aman.
I followed the arch/ppc/configs/ebony_defconfig and get a kernel.

Then I used the OpenBIOS to load that kernel. it is loaded fine, but the kernel
always
times out on "Sending BOOTP request..."

I used other machine to test my nfs server, it works fine.

Following is the screen out, Could you give me advice on the problem? Thanks.

Regards,

Jin Cheng


Loading file "C:\osop4m_vm/440gp/samples\zImage.ebony" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x1000000 ...
loaded at:     01000000 010981BC
zimage at:     010054E0 010944FB
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/nfs nfsroot=192.168.5.58:/EbonyNFS ip=192.168.5.249:19

2.168.5.58:::::::
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.20-pre4 (jcheng@hyperion) (gcc version 2.95.3 20010111 (prerel

ease/franzo/20010111)) #12 Tue Aug 27 17:57:05 PDT 2002
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=192.168.5.58:/EbonyNFS ip=192.168.5.2

49:192.168.5.58:::::::
Calibrating delay loop... 599.65 BogoMIPS
Memory: 127752k available (944k kernel code, 348k data, 212k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI en

abled
ttyS00 at 0xfdfe9200 (irq = 0) is a 16550A
ttyS01 at 0xfdfe8300 (irq = 1) is a 16550A
Zmii bridge in RMII mode
eth0: Phy @ 0x8, type Am79c875A (0x00225541)
Reset ethernet interfaces
Zmii bridge in RMII mode
eth1: Phy @ 0x9, type Am79c875A (0x00225541)
Reset ethernet interfaces
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
eth0: IBM EMAC: link up, 100 Mbps Half Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:1b:8d.
eth0: IBM EMAC: open completed

eth1: IBM EMAC: link up, 10 Mbps Half Duplex.
eth1: IBM EMAC: MAC 00:04:ac:e3:1b:8c.
eth1: IBM EMAC: open completed

Sending BOOTP requests ...... timed out!
Trying to free free IRQ61
Trying to free free IRQ32
Trying to free free IRQ33
Trying to free free IRQ34
Trying to free free IRQ10
Trying to free free IRQ11
IP-Config: Retrying forever (NFS root)...
eth0: IBM EMAC: link up, 100 Mbps Half Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:1b:8d.
eth0: IBM EMAC: open completed

eth1: IBM EMAC: link up, 10 Mbps Half Duplex.
eth1: IBM EMAC: MAC 00:04:ac:e3:1b:8c.
eth1: IBM EMAC: open completed

Sending BOOTP requests ....

===End of screen

Aman wrote:

> Hi Jin
>
> The eval kit for IBM PPC 440 has OpenBios as the rom monitor code. I
> compiled the PPC kernel with Mvista 405 compiler. As Matt Porter suggested,
> I download the zImage.ebony using the TFTP. The Image is downloaded to 440
> board, however finally it says PPC unknown. I trying some sample application
> on the ebony board now.
>
> Regards
> Aman
>
> ----- Original Message -----
> From: "Jin Cheng" <jcheng@redswitch.com>
> To: "Matt Porter" <porter@cox.net>
> Cc: "Aman" <aman@mistralsoftware.com>; "linuxppc embedded"
> <linuxppc-embedded@lists.linuxppc.org>
> Sent: Tuesday, August 27, 2002 11:08 PM
> Subject: Re: Downloading Image
>
> > Hi,
> >
> > I am wondering whether can use the OpenBIOS coming with the 440GP Ebony
> > board
> > to load the linux kernel or there is a ppcboot for Ebony which can do
> > that? Thanks.
> >
> > Sincerely,
> >
> > Jin
> >
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
