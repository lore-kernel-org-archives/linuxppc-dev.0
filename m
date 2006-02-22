Return-Path: <lijianggan@pmail.ntu.edu.sg>
Received: from exsmtp1.ntu.edu.sg (exsmtp1.ntu.edu.sg [155.69.5.207])
	by ozlabs.org (Postfix) with ESMTP id 76153679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Feb 2006 15:17:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63765.23E7AA2E"
Subject: boot failure on lite5200b board
Date: Wed, 22 Feb 2006 12:04:56 +0800
Message-ID: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
From: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C63765.23E7AA2E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

For my end-of-study project, I am working on an embedded system with =
reference of freescale's lite5200b reference board. I was trying to boot =
Linux 2.6.15 on the board (with the fec and bestcomm corrected). however =
the booting was stuck at the following stage:
U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)

## Booting image at 00100000 ...
   Image Name:   Linux-2.6.16-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658050 Bytes =3D 642.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit

I think it's probably the problem of kernel configuration prior to =
compilation. Has anybody got 2.6 kernel working probably lite5200b?

THE U-BOOT ENVIRONMENT SETTINGS:

=3D> printenv
baudrate=3D115200
autoload=3Dno
ethact=3DFEC ETHERNET
preboot=3Decho;echo Autostarting. Press any key to abort..;echo
bootdelay=3D5
hostname=3Dicecube
flshroot=3Droot=3D/dev/mtdblock2 rw
ethaddr=3D00:01:9F:00:27:2F
rootfs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
filesize=3Df2
fileaddr=3D100000
netmask=3D255.255.240.0
serverip=3D10.190.3.103
bootcmd=3Dtftp; bootm
bootfile=3DMPC5200/uImage
ipaddr=3D10.190.3.144
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff
nfsroot=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
bootargs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Environment size: 704/65532 bytes
=3D>              =20

THE WHLOE BOOTING MESSAGE:

U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)

CPU:   MPC5200 v2.2 at 462 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
Board: Freescale MPC5200 (Lite5200B)
I2C:   85 kHz, ready
DRAM:  256 MB
FLASH: 32 MB
PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5809  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IDE:   Bus 0: OK
  Device 0: not available
  Device 1: not available

Autostarting. Press any key to abort..

Hit any key to stop autoboot:  0
Using FEC ETHERNET device
TFTP from server 10.190.3.103; our IP address is 10.190.3.144
Filename 'MPC5200/uImage'.
Load address: 0x100000
Loading: =
#################################################################
         =
################################################################
done
Bytes transferred =3D 658114 (a0ac2 hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.6.16-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658050 Bytes =3D 642.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit

Thanks.

Jianggan LI


------_=_NextPart_001_01C63765.23E7AA2E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>boot failure on lite5200b board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello all,<BR>
<BR>
For my end-of-study project, I am working on an embedded system with =
reference of freescale's lite5200b reference board. I was trying to boot =
Linux 2.6.15 on the board (with the fec and bestcomm corrected). however =
the booting was stuck at the following stage:<BR>
U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<BR>
<BR>
## Booting image at 00100000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.16-rc1<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =3D 642.6 kB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
id mach(): done<BR>
MMU:enter<BR>
MMU:hw init<BR>
MMU:mapin<BR>
MMU:setio<BR>
MMU:exit<BR>
setup_arch: enter<BR>
setup_arch: bootmem<BR>
arch: exit<BR>
<BR>
I think it's probably the problem of kernel configuration prior to =
compilation. Has anybody got 2.6 kernel working probably lite5200b?<BR>
<BR>
THE U-BOOT ENVIRONMENT SETTINGS:<BR>
<BR>
=3D&gt; printenv<BR>
baudrate=3D115200<BR>
autoload=3Dno<BR>
ethact=3DFEC ETHERNET<BR>
preboot=3Decho;echo Autostarting. Press any key to abort..;echo<BR>
bootdelay=3D5<BR>
hostname=3Dicecube<BR>
flshroot=3Droot=3D/dev/mtdblock2 rw<BR>
ethaddr=3D00:01:9F:00:27:2F<BR>
rootfs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs<BR>
filesize=3Df2<BR>
fileaddr=3D100000<BR>
netmask=3D255.255.240.0<BR>
serverip=3D10.190.3.103<BR>
bootcmd=3Dtftp; bootm<BR>
bootfile=3DMPC5200/uImage<BR>
ipaddr=3D10.190.3.144<BR>
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff<BR>
nfsroot=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs<BR>
bootargs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<BR=
>
stdin=3Dserial<BR>
stdout=3Dserial<BR>
stderr=3Dserial<BR>
<BR>
Environment size: 704/65532 bytes<BR>
=3D&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;<BR>
<BR>
THE WHLOE BOOTING MESSAGE:<BR>
<BR>
U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<BR>
<BR>
CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 MHz<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, IPB 132 MHz, PCI 33 =
MHz<BR>
Board: Freescale MPC5200 (Lite5200B)<BR>
I2C:&nbsp;&nbsp; 85 kHz, ready<BR>
DRAM:&nbsp; 256 MB<BR>
FLASH: 32 MB<BR>
PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 1a&nbsp; 1057&nbsp; =
5809&nbsp; 0680&nbsp; 00<BR>
In:&nbsp;&nbsp;&nbsp; serial<BR>
Out:&nbsp;&nbsp; serial<BR>
Err:&nbsp;&nbsp; serial<BR>
Net:&nbsp;&nbsp; FEC ETHERNET<BR>
IDE:&nbsp;&nbsp; Bus 0: OK<BR>
&nbsp; Device 0: not available<BR>
&nbsp; Device 1: not available<BR>
<BR>
Autostarting. Press any key to abort..<BR>
<BR>
Hit any key to stop autoboot:&nbsp; 0<BR>
Using FEC ETHERNET device<BR>
TFTP from server 10.190.3.103; our IP address is 10.190.3.144<BR>
Filename 'MPC5200/uImage'.<BR>
Load address: 0x100000<BR>
Loading: =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
################################################################<BR>
done<BR>
Bytes transferred =3D 658114 (a0ac2 hex)<BR>
## Booting image at 00100000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.16-rc1<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =3D 642.6 kB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
id mach(): done<BR>
MMU:enter<BR>
MMU:hw init<BR>
MMU:mapin<BR>
MMU:setio<BR>
MMU:exit<BR>
setup_arch: enter<BR>
setup_arch: bootmem<BR>
arch: exit<BR>
<BR>
Thanks.<BR>
<BR>
Jianggan LI<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C63765.23E7AA2E--
