Return-Path: <rakeshbk402@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.231])
	by ozlabs.org (Postfix) with ESMTP id E884FDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 23:11:47 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so5744823qbe.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 07 Feb 2008 04:11:46 -0800 (PST)
Message-ID: <43455a600802070411w42b6745aqf87fa3ae88dcaf8c@mail.gmail.com>
Date: Thu, 7 Feb 2008 17:41:45 +0530
From: "rakesh bk" <rakeshbk402@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: porting xenomaii for power pc 750Cxe based SBC
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24647_30896001.1202386305575"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_24647_30896001.1202386305575
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everyone,

Iam Trying to port the xenomai-2.2.0 using the "
adeos-ipipe-2.6.14-ppc-1.3-05.patch"  to linux-kernel 2.6.14( Vanilla) to
our custom based SBC, After applying patches as i get Enough printk's on my
console , I get Stucked after UNMASKING of Ethernet Irq The following are
the printk messages after i tried to boot the image. can i know what the
actual problem is ...........

These are the following printks, which i get ,


ATSLinux:eth0:none console=ttyS0,9600 ip1=off
 Initializing init_irq
PID hash table entries: 1024 (order: 10, 16384 bytes)
time_init: decrementer frequency = 17.000000 MHz
Warning: real time clock seems stuck!
I-pipe 1.3-05: pipeline enabled.
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 125440k available (2716k kernel code, 1200k data, 148k init, 0k
highmem)
Mount-cache hash table entries: 512
softlockup thread 0 started up.
NET: Registered protocol family 16
PCI: Probing PCI hardware
Xenomai: ALTIVEC support enabled in kernel but no hardware found.
         Disable CONFIG_ALTIVEC in the kernel configuration.
Xenomai: system init failed, code -19.
Xenomai: native skin init failed, code -19.
Xenomai: starting POSIX services.
Xenomai: POSIX skin init failed, code -19.
Xenomai: RTDM skin init failed, code -19.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 85) is a 16550A
ttyS1 at MMIO 0x0 (irq = 86) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
eth%d: Couldn't Read Srom MAC address
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
physmap flash device: 10000 at f6000000
Generic platform RAM MTD, (c) 2004 Simtec Electronics
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
 Entering The Ethernet device : <NULL>
 UNMasking of Eth interrupt ( After generating the interrupt ).
 Retval of irq32 is : 0
gt64260_eth_open : Assigned IRQ 32 to gt64260_eth0

------=_Part_24647_30896001.1202386305575
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everyone,<br><br>Iam Trying to port the xenomai-2.2.0 using the &quot;adeos-ipipe-2.6.14-ppc-1.3-05.patch&quot;&nbsp; to linux-kernel 2.6.14( Vanilla) to our custom based SBC, After applying patches as i get Enough printk&#39;s on my console , I get Stucked after UNMASKING of Ethernet Irq The following are the printk messages after i tried to boot the image. can i know what the actual problem is ...........<br>
<br>These are the following printks, which i get ,<br><br><br>ATSLinux:eth0:none console=ttyS0,9600 ip1=off<br>&nbsp;Initializing init_irq<br>PID hash table entries: 1024 (order: 10, 16384 bytes)<br>time_init: decrementer frequency = 17.000000 MHz<br>
Warning: real time clock seems stuck!<br>I-pipe 1.3-05: pipeline enabled.<br>Console: colour dummy device 80x25<br>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
Memory: 125440k available (2716k kernel code, 1200k data, 148k init, 0k highmem)<br>Mount-cache hash table entries: 512<br>softlockup thread 0 started up.<br>NET: Registered protocol family 16<br>PCI: Probing PCI hardware<br>
Xenomai: ALTIVEC support enabled in kernel but no hardware found.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable CONFIG_ALTIVEC in the kernel configuration.<br>Xenomai: system init failed, code -19.<br>Xenomai: native skin init failed, code -19.<br>
Xenomai: starting POSIX services.<br>Xenomai: POSIX skin init failed, code -19.<br>Xenomai: RTDM skin init failed, code -19.<br>Installing knfsd (copyright (C) 1996 <a href="mailto:okir@monad.swb.de">okir@monad.swb.de</a>).<br>
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.<br>Initializing Cryptographic API<br>Generic RTC Driver v1.07<br>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled<br>ttyS0 at MMIO 0x0 (irq = 85) is a 16550A<br>
ttyS1 at MMIO 0x0 (irq = 86) is a 16550A<br>io scheduler noop registered<br>io scheduler anticipatory registered<br>io scheduler deadline registered<br>io scheduler cfq registered<br>loop: loaded (max 8 devices)<br>eth%d: Couldn&#39;t Read Srom MAC address<br>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<br>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx<br>physmap flash device: 10000 at f6000000<br>Generic platform RAM MTD, (c) 2004 Simtec Electronics<br>
mice: PS/2 mouse device common for all mice<br>NET: Registered protocol family 2<br>IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>TCP established hash table entries: 8192 (order: 3, 32768 bytes)<br>TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
TCP: Hash tables configured (established 8192 bind 8192)<br>TCP reno registered<br>TCP bic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>&nbsp;Entering The Ethernet device : &lt;NULL&gt;<br>
&nbsp;UNMasking of Eth interrupt ( After generating the interrupt ).<br>&nbsp;Retval of irq32 is : 0<br>gt64260_eth_open : Assigned IRQ 32 to gt64260_eth0<br><br>

------=_Part_24647_30896001.1202386305575--
