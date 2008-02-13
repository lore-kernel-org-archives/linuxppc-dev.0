Return-Path: <rakeshbk402@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 2450FDDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 21:56:34 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so5530481pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 02:56:33 -0800 (PST)
Message-ID: <43455a600802130256h56c098b5k18e7a4e6507f774@mail.gmail.com>
Date: Wed, 13 Feb 2008 16:26:31 +0530
From: "rakesh bk" <rakeshbk402@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Cannot mount root file system using nfs.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8976_24830958.1202900191716"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8976_24830958.1202900191716
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi EveryOne,

   I am new to Xenomai , I have ported linux-2.6.14 to our custom board
based on IBM750Cxe Iam unable to boot my kernel cross compiled with eldk-3.0with
   enabled xenomai support.If i remove xenomai and ipipe support the kernel
boots correctly , but if i enable CONFIG_IPIPE I get stuck in the before
mounting the root file system  .

   The following patches are applied and arguements of scripts/prepare-
   kernel.sh is mentioned as follows
   adeos-ipipe-2.6.14-ppc-1.3-05.patch,
   Target architecture [default i686]: ppc
   Adeos patch[default linux-2.6.14/xenomai-2.2.0
   /ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc64-1.2-03.patch]:
   adeos-ipipe-2.6.14-ppc-1.3-05.patch,


## Booting image at 00800000 ...
   Image Name:   Linux-2.6.14
   Created:      2008-02-13   8:23:56 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1568257 Bytes =  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
initrd != NULL ea100000
outside initrd
root=/dev/nfs rw nfsroot=192.168.50.92:/home/eldk/ppc_7xx ip=
192.168.50.39:192.168.50.92:192.168.50.92::ATSLinux:eth0:none c
onsole=ttyS0,9600 ip1=off
## Transferring control to Linux (at address 00000000) ...
Total memory = 128MB; using 256kB for hash table (at a03c0000)
Linux version 2.6.14 (root@localhost.localdomain) (gcc version
3.2.220030217 (Yellow Dog Linux
3.0 3.2.2-2a_1)) #38 PREEMPT
 Wed Feb 13 13:53:52 IST 2008
Kernel command line: root=/dev/nfs rw nfsroot=
192.168.50.92:/home/eldk/ppc_7xx ip=192.168.50.39:192.168.50.92:
192.168.50.92:
:ATSLinux:eth0:none console=ttyS0,9600 ip1=off
 Initializing init_irq
PID hash table entries: 1024 (order: 10, 16384 bytes)
time_init: decrementer frequency = 17.000000 MHz
Warning: real time clock seems stuck!
I-pipe 1.3-05: pipeline enabled.
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 125696k available (2588k kernel code, 960k data, 156k init, 0k
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
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 85) is a 16550A
ttyS1 at MMIO 0x0 (irq = 86) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
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
NET: Registered protocol family 15
gt64260_eth_open : Assigned IRQ 32 to gt64260_eth0
eth0: MII said 3, GT said 9, restarting autoneg
eth0: link state:
  GT:100: Link:HD:nFC
 mii:100: Link:FD: FC ANc:AN
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.50.39, mask=255.255.255.0, gw=192.168.50.92,
     host=ATSLinux, domain=, nis-domain=(none),
     bootserver=192.168.50.92, rootserver=192.168.50.92, rootpath=
Looking up port of RPC 100003/2 on 192.168.50.92

------=_Part_8976_24830958.1202900191716
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi EveryOne,<br><br><div style="text-align: left;"> &nbsp;&nbsp; I am new to Xenomai , I have ported linux-2.6.14 to our custom board based on IBM750Cxe Iam unable to boot my kernel cross compiled with eldk-3.0 with<br> &nbsp; &nbsp;enabled xenomai support.If i remove xenomai and ipipe support the kernel boots correctly , but if i enable CONFIG_IPIPE I get stuck in the before&nbsp; mounting the root file system&nbsp; .<br>
</div><br>


 &nbsp; &nbsp;The following patches are applied and arguements of scripts/prepare-<br> &nbsp; &nbsp;kernel.sh is mentioned as follows<br> &nbsp; &nbsp;adeos-ipipe-2.6.14-ppc-1.3-05.patch,<br> &nbsp; &nbsp;Target architecture [default i686]: ppc<br>

 &nbsp; &nbsp;Adeos patch[default linux-2.6.14/xenomai-2.2.0<br> &nbsp; &nbsp;/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc64-1.2-03.patch]:<br> &nbsp; &nbsp;adeos-ipipe-2.6.14-ppc-1.3-05<div>.patch,<br> &nbsp;&nbsp; <br><br></div>## Booting image at 00800000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.14<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-02-13&nbsp;&nbsp; 8:23:56 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1568257 Bytes =&nbsp; 1.5 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>initrd != NULL ea100000 <br>outside initrd<br>root=/dev/nfs rw nfsroot=192.168.50.92:/home/eldk/ppc_7xx ip=<a href="http://192.168.50.39:192">192.168.50.39:192</a>.168.50.92:192.168.50.92::ATSLinux:eth0:none c<br>
onsole=ttyS0,9600 ip1=off<br>## Transferring control to Linux (at address 00000000) ...<br>Total memory = 128MB; using 256kB for hash table (at a03c0000)<br>Linux version 2.6.14 (<a href="mailto:root@localhost.localdomain">root@localhost.localdomain</a>) (gcc version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #38 PREEMPT<br>
&nbsp;Wed Feb 13 13:53:52 IST 2008<br>Kernel command line: root=/dev/nfs rw nfsroot=192.168.50.92:/home/eldk/ppc_7xx ip=<a href="http://192.168.50.39:192">192.168.50.39:192</a>.168.50.92:<a href="http://192.168.50.92">192.168.50.92</a>:<br>
:ATSLinux:eth0:none console=ttyS0,9600 ip1=off<br>&nbsp;Initializing init_irq<br>PID hash table entries: 1024 (order: 10, 16384 bytes)<br>time_init: decrementer frequency = 17.000000 MHz<br>Warning: real time clock seems stuck!<br>
I-pipe 1.3-05: pipeline enabled.<br>Console: colour dummy device 80x25<br>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>Memory: 125696k available (2588k kernel code, 960k data, 156k init, 0k highmem)<br>
Mount-cache hash table entries: 512<br>softlockup thread 0 started up.<br>NET: Registered protocol family 16<br>PCI: Probing PCI hardware<br>Xenomai: ALTIVEC support enabled in kernel but no hardware found.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable CONFIG_ALTIVEC in the kernel configuration.<br>
Xenomai: system init failed, code -19.<br>Xenomai: native skin init failed, code -19.<br>Xenomai: starting POSIX services.<br>Xenomai: POSIX skin init failed, code -19.<br>Xenomai: RTDM skin init failed, code -19.<br>Installing knfsd (copyright (C) 1996 <a href="mailto:okir@monad.swb.de">okir@monad.swb.de</a>).<br>
Initializing Cryptographic API<br>Generic RTC Driver v1.07<br>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled<br>ttyS0 at MMIO 0x0 (irq = 85) is a 16550A<br>ttyS1 at MMIO 0x0 (irq = 86) is a 16550A<br>
io scheduler noop registered<br>io scheduler anticipatory registered<br>io scheduler deadline registered<br>io scheduler cfq registered<br>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize<br>loop: loaded (max 8 devices)<br>
nbd: registered device at major 43<br>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<br>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx<br>mice: PS/2 mouse device common for all mice<br>
NET: Registered protocol family 2<br>IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>TCP established hash table entries: 8192 (order: 3, 32768 bytes)<br>TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
TCP: Hash tables configured (established 8192 bind 8192)<br>TCP reno registered<br>TCP bic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>NET: Registered protocol family 15<br>gt64260_eth_open : Assigned IRQ 32 to gt64260_eth0<br>
eth0: MII said 3, GT said 9, restarting autoneg<br>eth0: link state:<br>&nbsp; GT:100: Link:HD:nFC<br>&nbsp;mii:100: Link:FD: FC ANc:AN<br>IP-Config: Guessing netmask <a href="http://255.255.255.0">255.255.255.0</a><br>IP-Config: Complete:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://192.168.50.39">192.168.50.39</a>, mask=<a href="http://255.255.255.0">255.255.255.0</a>, gw=<a href="http://192.168.50.92">192.168.50.92</a>,<br>&nbsp;&nbsp;&nbsp;&nbsp; host=ATSLinux, domain=, nis-domain=(none),<br>
&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://192.168.50.92">192.168.50.92</a>, rootserver=<a href="http://192.168.50.92">192.168.50.92</a>, rootpath=<br>Looking up port of RPC 100003/2 on <a href="http://192.168.50.92">192.168.50.92</a><br>

------=_Part_8976_24830958.1202900191716--
