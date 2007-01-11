Return-Path: <robers97@yahoo.com>
Received: from web56905.mail.re3.yahoo.com (web56905.mail.re3.yahoo.com
	[66.196.97.94]) by ozlabs.org (Postfix) with SMTP id 77406DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 15:49:35 +1100 (EST)
Message-ID: <20070111044253.88295.qmail@web56905.mail.re3.yahoo.com>
Date: Wed, 10 Jan 2007 20:42:53 -0800 (PST)
From: Steven Roberts <robers97@yahoo.com>
Subject: fs configuration for 2.4 Kernel build 8xx FADS (cramfs: wrong magic)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,=0A=0APlease advise me on what I should look to correct to get a RAM =
disk up and running.  I'm attempting to compile a minimal linux 2.4.25 kern=
el configuration for a 860FADS board with ELDK 4.0.  I'd like to have the f=
s contained in RAM.   This is my first time.  I've made more progress with =
the 2.4 kernel than the 2.6 kernel that came with the ELDK 4.0 tool chain. =
 Probably a user error, just wanted you guys to know I have considered star=
ting there.=0A=0AThe output I get follows:=0A=0A=3D>bootm 0x100000 0x001600=
00=0A## Booting image at 00100000 ...=0A   Image Name:   Linux-2.4.25=0A   =
Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A   Data Size: =
   338316 Bytes =3D 330.4 kB=0A   Load Address: 00000000=0A   Entry Point: =
 00000000=0A   Verifying Checksum ... OK=0A   Uncompressing Kernel Image ..=
. OK=0A## Loading RAMDisk Image at 00160000 ...=0A   Image Name:   Simple E=
mbedded Linux Framework=0A   Image Type:   PowerPC Linux RAMDisk Image (gzi=
p compressed)=0A   Data Size:    1433408 Bytes =3D  1.4 MB=0A   Load Addres=
s: 00000000=0A   Entry Point:  00000000=0A   Verifying Checksum ... OK=0A  =
 Loading Ramdisk to 003f7000, end 00554f40 ... OK=0ALinux version 2.4.25 (r=
oot@tnkdemo.ibm.com) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #14 Wed Jan =
10 22:58:05 CST 2007=0AOn node 0 totalpages: 2048=0Azone(0): 2048 pages.=0A=
zone(1): 0 pages.=0Azone(2): 0 pages.=0AKernel command line: root=3D/dev/ra=
m rw panic=3D1 console=3DttyS0,115200=0ADecrementer Frequency =3D 150000000=
/60=0ACalibrating delay loop... 39.83 BogoMIPS=0AMemory: 7216k available (5=
88k kernel code, 244k data, 36k init, 0k highmem)=0ADentry cache hash table=
 entries: 1024 (order: 1, 8192 bytes)=0AInode cache hash table entries: 512=
 (order: 0, 4096 bytes)=0AMount cache hash table entries: 512 (order: 0, 40=
96 bytes)=0ABuffer cache hash table entries: 1024 (order: 0, 4096 bytes)=0A=
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)=0APOSIX conforma=
nce testing by UNIFIX=0ALinux NET4.0 for Linux 2.4=0ABased upon Swansea Uni=
versity Computer Society NET3.039=0AStarting kswapd=0ACPM UART driver versi=
on 0.04=0AttyS0 at 0x0280 is on SMC1 using BRG1=0AttyS1 at 0x0380 is on SMC=
2 using BRG2=0Apty: 256 Unix98 ptys configured=0ARAMDISK driver initialized=
: 16 RAM disks of 4096K size 1024 blocksize=0Aloop: loaded (max 8 devices)=
=0Acramfs: wrong magic=0AKernel panic: VFS: Unable to mount root fs on 01:0=
0=0A=0AThanks in advance!=0A=0A=0A=0A=0A=0A =0A____________________________=
________________________________________________________=0AWant to start yo=
ur own business?=0ALearn how on Yahoo! Small Business.=0Ahttp://smallbusine=
ss.yahoo.com/r-index
