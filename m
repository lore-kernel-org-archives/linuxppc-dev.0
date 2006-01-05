Return-Path: <batsayan.das@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 98C0168929
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 16:12:30 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OF297B9EF6.35EC8CDF-ON652570ED.001A9607-652570ED.001B4CAD@tcs.com>
Date: Thu, 5 Jan 2006 10:28:10 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001B4C79652570ED_="
Subject: Porting of Linux on MPC8260 custom build board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 001B4C79652570ED_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,

Linux is able to uncompress into SDRAM. We mapped SDRAM from 0x0. It is=0D
getting stuck at mounting root fs. We have mounted the root fs by NSF.=0D
Possibly it is not able to contact the server where it's FS is mounted.=0D
Pls find the following log and help me to bring up Linux. Our board has=0D
single ethernet and uses FCC1 with LXT971 driver. The board does not have=0D
BCSR.=0D

**********************LOG START*********************

U-BOOT=3D> boot,=08 =08m 04000000

## Booting image at 04000000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    661935 Bytes =3D 646.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x07B87CA8 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF13
bd address  =3D 0x07B87FB4
memstart    =3D 0x00000000
memsize     =3D 0x08000000
flashstart  =3D 0xFE000000
flashsize   =3D 0x00100000
flashoffset =3D 0x00032000
sramstart   =3D 0xFFF00000
sramsize    =3D 0x00200000
immr_base   =3D 0xF0000000
bootflags   =3D 0x00000001
vco         =3D    248 MHz
sccfreq     =3D     62 MHz
brgfreq     =3D 15.500 MHz
intfreq     =3D    186 MHz
cpmfreq     =3D    124 MHz
busfreq     =3D     62 MHz
ethaddr     =3D 00:0B:17:00:00:00
IP addr     =3D 172.18.16.220
baudrate    =3D  57600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb
Linux version 2.4.25 (cdot@myserver.com) (gcc version 3.3.3 (DENX ELDK=0D
3.1.1 3.3.3-9)) #3 Wed Jan 4 15:48:00 IST 2006
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/mtdblock2
Warning: real time clock seems stuck!
Calibrating delay loop... 123.69 BogoMIPS
Memory: 127932k available (1136k kernel code, 400k data, 52k init, 0k=0D
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
CPM UART driver version 0.01
ttyS0 on SMC1 at 0x0000, BRG7
ttyS1 on SMC2 at 0x0040, BRG8
ttyS2 on SCC1 at 0x8000, BRG1
ttyS3 on SCC2 at 0x8100, BRG2
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Cannot open root device "mtdblock2" or 1f:02
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 1f:02
 <0>Rebooting in 180 seconds..
***************************LOG END*******************************

Thanks
Batsayan Das


Notice: The information contained in this e-mail message and/or attachments=
 to it may contain confidential or privileged information.   If you are not=
 the intended recipient, any dissemination, use, review, distribution,=
 printing or copying of the information contained in this e-mail message=
 and/or attachments to it are strictly prohibited.   If you have received=
 this communication in error, please notify us by reply e-mail or telephone=
 and immediately and permanently delete the message and any attachments. =
 Thank you
--=_alternative 001B4C79652570ED_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Linux is able to uncompress into=
 SDRAM.
We mapped SDRAM from 0x0. It is getting stuck at mounting root fs. We have
mounted the root fs by NSF. Possibly it is not able to contact the server
where it's FS is mounted. Pls find the following log and help me to bring
up Linux. Our board has single ethernet and uses FCC1 with LXT971 driver.
The board does not have BCSR. &nbsp;</font>
<br>
<br><font size=3D2 face=3D"sans-serif">**********************LOG=
 START*********************</font>
<br>
<br><font size=3D2 face=3D"sans-serif">U-BOOT=3D&gt; boot,=08 =08m=
 04000000</font>
<br>
<br><font size=3D2 face=3D"sans-serif">## Booting image at 04000000=
 ...</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Name: &nbsp;=
 Linux-2.4.25</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Type: &nbsp;=
 PowerPC
Linux Kernel Image (gzip compressed)</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Data Size: &nbsp;=
 &nbsp;661935
Bytes =3D 646.4 kB</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Load Address:=
 00000000</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Entry Point:=
 &nbsp;00000000</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Verifying Checksum ...
OK</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Uncompressing Kernel=
 Image
... OK</font>
<br><font size=3D2 face=3D"sans-serif">## Current stack ends at 0x07B87CA8
=3D&gt; set upper limit to 0x00800000</font>
<br><font size=3D2 face=3D"sans-serif">## cmdline at 0x007FFF00 ...=
 0x007FFF13</font>
<br><font size=3D2 face=3D"sans-serif">bd address &nbsp;=3D=
 0x07B87FB4</font>
<br><font size=3D2 face=3D"sans-serif">memstart &nbsp; &nbsp;=3D=
 0x00000000</font>
<br><font size=3D2 face=3D"sans-serif">memsize &nbsp; &nbsp; =3D=
 0x08000000</font>
<br><font size=3D2 face=3D"sans-serif">flashstart &nbsp;=3D=
 0xFE000000</font>
<br><font size=3D2 face=3D"sans-serif">flashsize &nbsp; =3D=
 0x00100000</font>
<br><font size=3D2 face=3D"sans-serif">flashoffset =3D 0x00032000</font>
<br><font size=3D2 face=3D"sans-serif">sramstart &nbsp; =3D=
 0xFFF00000</font>
<br><font size=3D2 face=3D"sans-serif">sramsize &nbsp; &nbsp;=3D=
 0x00200000</font>
<br><font size=3D2 face=3D"sans-serif">immr_base &nbsp; =3D=
 0xF0000000</font>
<br><font size=3D2 face=3D"sans-serif">bootflags &nbsp; =3D=
 0x00000001</font>
<br><font size=3D2 face=3D"sans-serif">vco &nbsp; &nbsp; &nbsp; &nbsp; =3D=
 &nbsp;
&nbsp;248 MHz</font>
<br><font size=3D2 face=3D"sans-serif">sccfreq &nbsp; &nbsp; =3D &nbsp;=
 &nbsp;
62 MHz</font>
<br><font size=3D2 face=3D"sans-serif">brgfreq &nbsp; &nbsp; =3D 15.500=
 MHz</font>
<br><font size=3D2 face=3D"sans-serif">intfreq &nbsp; &nbsp; =3D &nbsp;=
 &nbsp;186
MHz</font>
<br><font size=3D2 face=3D"sans-serif">cpmfreq &nbsp; &nbsp; =3D &nbsp;=
 &nbsp;124
MHz</font>
<br><font size=3D2 face=3D"sans-serif">busfreq &nbsp; &nbsp; =3D &nbsp;=
 &nbsp;
62 MHz</font>
<br><font size=3D2 face=3D"sans-serif">ethaddr &nbsp; &nbsp; =3D=
 00:0B:17:00:00:00</font>
<br><font size=3D2 face=3D"sans-serif">IP addr &nbsp; &nbsp; =3D=
 172.18.16.220</font>
<br><font size=3D2 face=3D"sans-serif">baudrate &nbsp; &nbsp;=3D=
 &nbsp;57600
bps</font>
<br><font size=3D2 face=3D"sans-serif">No initrd</font>
<br><font size=3D2 face=3D"sans-serif">## Transferring control to Linux (at
address 00000000) ...</font>
<br><font size=3D2 face=3D"sans-serif">Memory BAT mapping: BAT2=3D128Mb,=
 BAT3=3D0Mb,
residual: 0Mb</font>
<br><font size=3D2 face=3D"sans-serif">Linux version 2.4.25=
 (cdot@myserver.com)
(gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9)) #3 Wed Jan 4 15:48:00 IST
2006</font>
<br><font size=3D2 face=3D"sans-serif">On node 0 totalpages: 32768</font>
<br><font size=3D2 face=3D"sans-serif">zone(0): 32768 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(1): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(2): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">Kernel command line: root=
=3D/dev/mtdblock2</font>
<br><font size=3D2 face=3D"sans-serif">Warning: real time clock seems=
 stuck!</font>
<br><font size=3D2 face=3D"sans-serif">Calibrating delay loop... 123.69=
 BogoMIPS</font>
<br><font size=3D2 face=3D"sans-serif">Memory: 127932k available (1136k=
 kernel
code, 400k data, 52k init, 0k highmem)</font>
<br><font size=3D2 face=3D"sans-serif">Dentry cache hash table entries:=
 16384
(order: 5, 131072 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Inode cache hash table entries: 8192
(order: 4, 65536 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Mount cache hash table entries: 512
(order: 0, 4096 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Buffer cache hash table entries:=
 8192
(order: 3, 32768 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Page-cache hash table entries: 32768
(order: 5, 131072 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">POSIX conformance testing by=
 UNIFIX</font>
<br><font size=3D2 face=3D"sans-serif">Linux NET4.0 for Linux 2.4</font>
<br><font size=3D2 face=3D"sans-serif">Based upon Swansea University=
 Computer
Society NET3.039</font>
<br><font size=3D2 face=3D"sans-serif">Initializing RT netlink=
 socket</font>
<br><font size=3D2 face=3D"sans-serif">Starting kswapd</font>
<br><font size=3D2 face=3D"sans-serif">JFFS2 version 2.2. (C) 2001-2003 Red
Hat, Inc.</font>
<br><font size=3D2 face=3D"sans-serif">CPM UART driver version 0.01</font>
<br><font size=3D2 face=3D"sans-serif">ttyS0 on SMC1 at 0x0000, BRG7</font>
<br><font size=3D2 face=3D"sans-serif">ttyS1 on SMC2 at 0x0040, BRG8</font>
<br><font size=3D2 face=3D"sans-serif">ttyS2 on SCC1 at 0x8000, BRG1</font>
<br><font size=3D2 face=3D"sans-serif">ttyS3 on SCC2 at 0x8100, BRG2</font>
<br><font size=3D2 face=3D"sans-serif">pty: 256 Unix98 ptys=
 configured</font>
<br><font size=3D2 face=3D"sans-serif">RAMDISK driver initialized: 16 RAM=
 disks
of 4096K size 1024 blocksize</font>
<br><font size=3D2 face=3D"sans-serif">NET4: Linux TCP/IP 1.0 for=
 NET4.0</font>
<br><font size=3D2 face=3D"sans-serif">IP Protocols: ICMP, UDP, TCP</font>
<br><font size=3D2 face=3D"sans-serif">IP: routing cache hash table of 1024
buckets, 8Kbytes</font>
<br><font size=3D2 face=3D"sans-serif">TCP: Hash tables configured=
 (established
8192 bind 16384)</font>
<br><font size=3D2 face=3D"sans-serif">NET4: Unix domain sockets 1.0/SMP=
 for
Linux NET4.0.</font>
<br><font size=3D2 face=3D"sans-serif">VFS: Cannot open root device=
 &quot;mtdblock2&quot;
or 1f:02</font>
<br><font size=3D2 face=3D"sans-serif">Please append a correct &quot;root=
=3D&quot;
boot option</font>
<br><font size=3D2 face=3D"sans-serif">Kernel panic: VFS: Unable to mount=
 root
fs on 1f:02</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;&lt;0&gt;Rebooting in 180=
 seconds..</font>
<br><font size=3D2 face=3D"sans-serif">***************************LOG=
 END*******************************</font>
<br><font size=3D2 face=3D"sans-serif"><br>
Thanks</font>
<br><font size=3D2 face=3D"sans-serif">Batsayan Das<br>
</font>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>Notice: The=
 information contained in this e-mail message and/or attachments to it may=
 contain confidential or privileged information.   If you are not the=
 intended recipient, any dissemination, use, review, distribution, printing=
 or copying of the information contained in this e-mail message and/or=
 attachments to it are strictly prohibited.   If you have received this=
 communication in error, please notify us by reply e-mail or telephone and=
 immediately and permanently delete the message and any attachments.  Thank=
 you<br>
</font></td></tr></table>
--=_alternative 001B4C79652570ED_=--
