Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6b.your-server.co.za [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 095A7DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Aug 2008 19:30:14 +1000 (EST)
Message-ID: <48A2A99C.5000309@vastech.co.za>
Date: Wed, 13 Aug 2008 11:30:04 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Mounting PRAMFS support
References: <48A15FC3.3060008@vastech.co.za>
	<20080812181138.BEF53248BF@gemini.denx.de>
In-Reply-To: <20080812181138.BEF53248BF@gemini.denx.de>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms090707020704020100020107"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a cryptographically signed message in MIME format.

--------------ms090707020704020100020107
Content-Type: multipart/alternative;
 boundary="------------070904010909020802050303"

This is a multi-part message in MIME format.
--------------070904010909020802050303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Wolfgang

thanks for your quick reply. Below i have placed the boot message,
Another question I have that might help is that in DULG  section 5.10
where the environmental variable "pram" is defined,  the documentation
states "If the "Protected RAM" feature is enabled in your board's
configuration" 
Is the PRAMFS support  built in and available when CONFIG_PRAM and the
"pram" environmental variable is defined in the board config or are
there other elements to be configured or activated on the linux side
aswell?.  (mpc8548 board using  ELDK 4.1 ppc_85xx)

The boot message:

U-Boot 1.2.0 (Aug 12 2008 - 16:21:15)

CPU:   8548_E, Version: 1.1, (0x80390011)
Core:  E500, Version: 1.0, (0x80210010)
Clock Configuration:
       CPU: 990 MHz, CCB: 396 MHz,
       DDR: 198 MHz, LBC:  49 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: Equus MPC8548
    PCI1: 64 bit, 66 MHz, sync
I2C:   ready
DRAM:  Initializing
    DDR: 512 MB
FLASH: 128 MB
L2 cache 512KB: enabled
*** Warning - bad CRC, using default environment

BIE:
  serial number = EQ_0002
  build level   = EQUUS-1.1
  set ethaddr  to 00:50:C2:52:50:FC
  set eth1addr to 00:50:C2:52:50:FD
  set eth2addr to 00:50:C2:52:50:FE
  set bootsrc  to factory
Running boot diagnostics
In:    serial
Out:   serial
Err:   serial
Net:   eTSEC0, eTSEC1, eTSEC2
boot count loaded 1
boot count stored 2
Hit any key to stop autoboot:  0
### CRAMFS loading '/boot/uImage' to 0x200000
### CRAMFS load complete: 1067930 bytes loaded to 0x200000
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.19.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1067866 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory CAM mapping: CAM0=256Mb, CAM1=64Mb, CAM2=64Mb residual: 64Mb
Linux version 2.6.19.2 (root@sdh-ts2) (gcc version 4.0.0 (DENX ELDK 4.1
4.0.0)) #1 Tue Aug 12 15:56:47 SAST 2008
Zone PFN ranges:
  DMA             0 ->    98304
  Normal      98304 ->    98304
early_node_map[1] active PFN ranges
    0:        0 ->    98304
Built 1 zonelists.  Total pages: 97536
Kernel command line: root=/dev/mtdblock0 ro console=ttyS0,115200 mem=458752k
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 387328k available (1712k kernel code, 500k data, 136k init, 0k
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
PCI: Failed to allocate mem resource #1:80000000@0 for 0000:00:00.0
Generic PHY: Registered new driver
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 26) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 26) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2(MW), 00:50:c2:52:50:fc
eth0: Running with NAPI enabled
eth0: 256/1024 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2(MW), 00:50:c2:52:50:fd
eth1: Running with NAPI enabled
eth1: 256/1024 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2(MW), 00:50:c2:52:50:fe
eth2: Running with NAPI enabled
eth2: 256/1024 RX/TX BD ring size
Cicada Cis8204: Registered new driver
Cicada Cis8201: Registered new driver
0: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Equus flash bank 0: Using static image bank1 partition definition
Creating 9 MTD partitions on "0":
0x00000000-0x01000000 : "factory-image"
mtd: Giving out device 0 to factory-image
0x01000000-0x02000000 : "app-image-1"
mtd: Giving out device 1 to app-image-1
0x02000000-0x03000000 : "app-image-2"
mtd: Giving out device 2 to app-image-2
0x03000000-0x04000000 : "jffs2"
mtd: Giving out device 3 to jffs2
0x04000000-0x05000000 : "testing"
mtd: Giving out device 4 to testing
0x05000000-0x07f40000 : "reserved"
mtd: Giving out device 5 to reserved
0x07f40000-0x07f80000 : "u-boot-env"
mtd: Giving out device 6 to u-boot-env
0x07f80000-0x08000000 : "u-boot-app"
mtd: Giving out device 7 to u-boot-app
0x00000000-0x08000000 : "all"
mtd: Giving out device 8 to all
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 136k init
INIT: version 2.85 booting
$Mounting /dev/mtdblock2 to /usr/config
jffs2 Mount Sucsesfull. Checking config files
cron.daily file missing - Copy from defaults
cron.hourly file missing - Copy from defaults
cron.weekly file missing - Copy from defaults
ifcfg-eth0 file exist - Skipping
ifcfg-eth1 file exist - Skipping
ifcfg-eth2 file exist - Skipping
logrotate.conf file exist - Skipping
ntp.conf file exist - Skipping
resolv.conf file exist - Skipping
syslog.conf file exist - Skipping
$               Welcome to $DENX Embedded$ Linux Environment
$               VAStech SDH Gateway
$               Press 'I' to enter interactive startup.
$ done[  $OK  ]
$Setting clock : Thu Jan  1 00:00:01 UTC 1970 [  $OK  ]
$Setting hostname sdh-gateway:  [  $OK  ]
$Mounting local filesystems:  [  $OK  ]
INIT: Entering runlevel: 3
current directory/etc/sysconfig/network-scripts
$Bringing up loopback interface:  Hardware Address
[  $OK  ]
$Bringing up interface eth0:  Hardware Address
[  $OK  ]
$Bringing up interface eth1:  Hardware Address
[  $OK  ]
$Bringing up interface eth2:  Hardware Address
[  $OK  ]
$Starting system logger: [  $OK  ]
$Starting kernel logger: [  $OK  ]
$Starting xinetd: [  $OK  ]
$Starting ntpd: [  $OK  ]
$Starting periodic command scheduler : [  $OK  ]

DENX ELDK version 4.0 build 2006-01-12
Linux 2.6.19.2 on a ppc


When i then try to mount  the PRAMFS i get the following:

sh\$ mount -t pramfs -o physaddr=0x1c000000,init=0x4000000 none /tmp/test/
mount: mounting none on /tmp/test/ failed: No such device
sh\$

I might be missing something simple. There are no recent documentation
regarding PRAMFS  is it still suported or has it been abandoned?

thanks for your time Pieter

Wolfgang Denk wrote:
> Dear Pieter,
>
> In message <48A15FC3.3060008@vastech.co.za> you wrote:
>   
>> Im using a ppc85xx processor with Denx ELDK (4.1) The board  has 512MB
>> DDR2 and the board config reserves 64M for pram. during bootup the
>> mem=$mem argument is passed to the linux kernel command line and linux
>> boots successfully.
>>     
>
> So what are the exact boot messages of your kernel?
>
>   
>> I am unable to mount the PRAMFS - all documentation leads me to use
>>
>> mount -t pramfs -o physaddr=0x1c000000,init=0x4000000 none /mnt
>>     
> -------------------------------------------------------------^^^^
>   
>> witch fails with the message:
>> mounting none on /mtd failed: no such devise 
>>     
> -------------------^^^^
>
> /mnt != /mtd
>   
--------------^^^^
This was a typo
> There is something worng, probably your description. It would be
> better if you showed the precise commands and outpout from your
> target system.
>
> Best regards,
>
> Wolfgang Denk
>
>   

-- 
Pieter Henning
VASTech

Tel: +27 (0)21 850 5921
Fax: +27 (0)86 503 8941
e-mail: phenning@vastech.co.za


--------------070904010909020802050303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Wolfgang<br>
<br>
thanks for your quick reply. Below i have placed the boot message,
Another question I have that might help is that in DULG&nbsp; section 5.10
where the
environmental variable "pram" is defined,&nbsp; the documentation states "If
the
"Protected RAM" feature is enabled in your board's configuration"&nbsp; <br>
Is the PRAMFS support&nbsp; built in and available when CONFIG_PRAM and the
"pram" environmental variable is defined in the board config or are
there other elements to be configured or activated on the linux side
aswell?.&nbsp; (mpc8548 board using&nbsp; ELDK 4.1 ppc_85xx)<br>
<br>
The boot message:<br>
<br>
U-Boot 1.2.0 (Aug 12 2008 - 16:21:15)<br>
<br>
CPU:&nbsp;&nbsp; 8548_E, Version: 1.1, (0x80390011)<br>
Core:&nbsp; E500, Version: 1.0, (0x80210010)<br>
Clock Configuration:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU: 990 MHz, CCB: 396 MHz,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DDR: 198 MHz, LBC:&nbsp; 49 MHz<br>
L1:&nbsp;&nbsp;&nbsp; D-cache 32 kB enabled<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I-cache 32 kB enabled<br>
Board: Equus MPC8548<br>
&nbsp;&nbsp;&nbsp; PCI1: 64 bit, 66 MHz, sync<br>
I2C:&nbsp;&nbsp; ready<br>
DRAM:&nbsp; Initializing<br>
&nbsp;&nbsp;&nbsp; DDR: 512 MB<br>
FLASH: 128 MB<br>
L2 cache 512KB: enabled<br>
*** Warning - bad CRC, using default environment<br>
<br>
BIE:<br>
&nbsp; serial number = EQ_0002<br>
&nbsp; build level&nbsp;&nbsp; = EQUUS-1.1<br>
&nbsp; set ethaddr&nbsp; to 00:50:C2:52:50:FC<br>
&nbsp; set eth1addr to 00:50:C2:52:50:FD<br>
&nbsp; set eth2addr to 00:50:C2:52:50:FE<br>
&nbsp; set bootsrc&nbsp; to factory<br>
Running boot diagnostics <br>
In:&nbsp;&nbsp;&nbsp; serial<br>
Out:&nbsp;&nbsp; serial<br>
Err:&nbsp;&nbsp; serial<br>
Net:&nbsp;&nbsp; eTSEC0, eTSEC1, eTSEC2<br>
boot count loaded 1 <br>
boot count stored 2 <br>
Hit any key to stop autoboot:&nbsp; 0 <br>
### CRAMFS loading '/boot/uImage' to 0x200000<br>
### CRAMFS load complete: 1067930 bytes loaded to 0x200000<br>
## Booting image at 00200000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.19.2<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1067866 Bytes =&nbsp; 1 MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
Memory CAM mapping: CAM0=256Mb, CAM1=64Mb, CAM2=64Mb residual: 64Mb<br>
Linux version 2.6.19.2 (root@sdh-ts2) (gcc version 4.0.0 (DENX ELDK 4.1
4.0.0)) #1 Tue Aug 12 15:56:47 SAST 2008<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 98304<br>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 98304 -&gt;&nbsp;&nbsp;&nbsp; 98304<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 98304<br>
Built 1 zonelists.&nbsp; Total pages: 97536<br>
Kernel command line: root=/dev/mtdblock0 ro console=ttyS0,115200
mem=458752k<br>
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000<br>
PID hash table entries: 2048 (order: 11, 8192 bytes)<br>
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<br>
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
Memory: 387328k available (1712k kernel code, 500k data, 136k init, 0k
highmem)<br>
Mount-cache hash table entries: 512<br>
NET: Registered protocol family 16<br>
PCI: Probing PCI hardware<br>
PCI: Cannot allocate resource region 0 of device 0000:00:00.0<br>
PCI: Cannot allocate resource region 1 of device 0000:00:00.0<br>
PCI: Failed to allocate mem resource #1:80000000@0 for 0000:00:00.0<br>
Generic PHY: Registered new driver<br>
NET: Registered protocol family 2<br>
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)<br>
TCP established hash table entries: 16384 (order: 4, 65536 bytes)<br>
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
TCP: Hash tables configured (established 16384 bind 8192)<br>
TCP reno registered<br>
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.<br>
io scheduler noop registered<br>
io scheduler anticipatory registered (default)<br>
io scheduler deadline registered<br>
io scheduler cfq registered<br>
Generic RTC Driver v1.07<br>
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled<br>
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 26) is a 16550A<br>
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 26) is a 16550A<br>
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize<br>
loop: loaded (max 8 devices)<br>
Gianfar MII Bus: probed<br>
eth0: Gianfar Ethernet Controller Version 1.2(MW), 00:50:c2:52:50:fc <br>
eth0: Running with NAPI enabled<br>
eth0: 256/1024 RX/TX BD ring size<br>
eth1: Gianfar Ethernet Controller Version 1.2(MW), 00:50:c2:52:50:fd <br>
eth1: Running with NAPI enabled<br>
eth1: 256/1024 RX/TX BD ring size<br>
eth2: Gianfar Ethernet Controller Version 1.2(MW), 00:50:c2:52:50:fe <br>
eth2: Running with NAPI enabled<br>
eth2: 256/1024 RX/TX BD ring size<br>
Cicada Cis8204: Registered new driver<br>
Cicada Cis8201: Registered new driver<br>
0: Found 2 x16 devices at 0x0 in 32-bit bank<br>
&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br>
0: CFI does not contain boot bank location. Assuming top.<br>
number of CFI chips: 1<br>
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>
Equus flash bank 0: Using static image bank1 partition definition<br>
Creating 9 MTD partitions on "0":<br>
0x00000000-0x01000000 : "factory-image"<br>
mtd: Giving out device 0 to factory-image<br>
0x01000000-0x02000000 : "app-image-1"<br>
mtd: Giving out device 1 to app-image-1<br>
0x02000000-0x03000000 : "app-image-2"<br>
mtd: Giving out device 2 to app-image-2<br>
0x03000000-0x04000000 : "jffs2"<br>
mtd: Giving out device 3 to jffs2<br>
0x04000000-0x05000000 : "testing"<br>
mtd: Giving out device 4 to testing<br>
0x05000000-0x07f40000 : "reserved"<br>
mtd: Giving out device 5 to reserved<br>
0x07f40000-0x07f80000 : "u-boot-env"<br>
mtd: Giving out device 6 to u-boot-env<br>
0x07f80000-0x08000000 : "u-boot-app"<br>
mtd: Giving out device 7 to u-boot-app<br>
0x00000000-0x08000000 : "all"<br>
mtd: Giving out device 8 to all<br>
i2c /dev entries driver<br>
TCP cubic registered<br>
NET: Registered protocol family 1<br>
NET: Registered protocol family 17<br>
VFS: Mounted root (cramfs filesystem) readonly.<br>
Freeing unused kernel memory: 136k init<br>
INIT: version 2.85 booting<br>
$Mounting /dev/mtdblock2 to /usr/config<br>
jffs2 Mount Sucsesfull. Checking config files<br>
cron.daily file missing - Copy from defaults<br>
cron.hourly file missing - Copy from defaults<br>
cron.weekly file missing - Copy from defaults<br>
ifcfg-eth0 file exist - Skipping<br>
ifcfg-eth1 file exist - Skipping<br>
ifcfg-eth2 file exist - Skipping<br>
logrotate.conf file exist - Skipping<br>
ntp.conf file exist - Skipping<br>
resolv.conf file exist - Skipping<br>
syslog.conf file exist - Skipping<br>
$&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Welcome to $DENX Embedded$ Linux Environment<br>
$&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VAStech SDH Gateway<br>
$&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Press 'I' to enter interactive startup.<br>
$ done[&nbsp; $OK&nbsp; ]<br>
$Setting clock : Thu Jan&nbsp; 1 00:00:01 UTC 1970 [&nbsp; $OK&nbsp; ]<br>
$Setting hostname sdh-gateway:&nbsp; [&nbsp; $OK&nbsp; ]<br>
$Mounting local filesystems:&nbsp; [&nbsp; $OK&nbsp; ]<br>
INIT: Entering runlevel: 3<br>
current directory/etc/sysconfig/network-scripts<br>
$Bringing up loopback interface:&nbsp; Hardware Address <br>
[&nbsp; $OK&nbsp; ]<br>
$Bringing up interface eth0:&nbsp; Hardware Address <br>
[&nbsp; $OK&nbsp; ]<br>
$Bringing up interface eth1:&nbsp; Hardware Address <br>
[&nbsp; $OK&nbsp; ]<br>
$Bringing up interface eth2:&nbsp; Hardware Address <br>
[&nbsp; $OK&nbsp; ]<br>
$Starting system logger: [&nbsp; $OK&nbsp; ]<br>
$Starting kernel logger: [&nbsp; $OK&nbsp; ]<br>
$Starting xinetd: [&nbsp; $OK&nbsp; ]<br>
$Starting ntpd: [&nbsp; $OK&nbsp; ]<br>
$Starting periodic command scheduler : [&nbsp; $OK&nbsp; ]<br>
<br>
DENX ELDK version 4.0 build 2006-01-12<br>
Linux 2.6.19.2 on a ppc<br>
<br>
<br>
When i then try to mount&nbsp; the PRAMFS i get the following: <br>
<br>
sh\$ mount -t pramfs -o physaddr=0x1c000000,init=0x4000000 none
/tmp/test/<br>
mount: mounting none on /tmp/test/ failed: No such device<br>
sh\$ <br>
<br>
I might be missing something simple. There are no recent documentation
regarding PRAMFS&nbsp; is it still suported or has it been abandoned?<br>
<br>
thanks for your time Pieter<br>
<br>
Wolfgang Denk wrote:
<blockquote cite="mid:20080812181138.BEF53248BF@gemini.denx.de"
 type="cite">
  <pre wrap="">Dear Pieter,

In message <a class="moz-txt-link-rfc2396E" href="mailto:48A15FC3.3060008@vastech.co.za">&lt;48A15FC3.3060008@vastech.co.za&gt;</a> you wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Im using a ppc85xx processor with Denx ELDK (4.1) The board  has 512MB
DDR2 and the board config reserves 64M for pram. during bootup the
mem=$mem argument is passed to the linux kernel command line and linux
boots successfully.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
So what are the exact boot messages of your kernel?

  </pre>
  <blockquote type="cite">
    <pre wrap="">I am unable to mount the PRAMFS - all documentation leads me to use

mount -t pramfs -o physaddr=0x1c000000,init=0x4000000 none /mnt
    </pre>
  </blockquote>
  <pre wrap=""><!---->-------------------------------------------------------------^^^^
  </pre>
  <blockquote type="cite">
    <pre wrap="">witch fails with the message:
mounting none on /mtd failed: no such devise 
    </pre>
  </blockquote>
  <pre wrap=""><!---->-------------------^^^^

/mnt != /mtd
  </pre>
</blockquote>
--------------^^^^<br>
This was a typo<br>
<blockquote cite="mid:20080812181138.BEF53248BF@gemini.denx.de"
 type="cite">
  <pre wrap="">
There is something worng, probably your description. It would be
better if you showed the precise commands and outpout from your
target system.

Best regards,

Wolfgang Denk

  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="72">-- 
Pieter Henning
VASTech

Tel: +27 (0)21 850 5921
Fax: +27 (0)86 503 8941
e-mail: <a class="moz-txt-link-abbreviated" href="mailto:phenning@vastech.co.za">phenning@vastech.co.za</a>
</pre>
</body>
</html>

--------------070904010909020802050303--

--------------ms090707020704020100020107
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
8tXhyksFQPFQpPxoIjqNUQAAAAAAAA==
--------------ms090707020704020100020107--
