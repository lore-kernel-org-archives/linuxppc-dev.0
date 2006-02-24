Return-Path: <lijianggan@pmail.ntu.edu.sg>
Received: from exsmtp1.ntu.edu.sg (exsmtp1.ntu.edu.sg [155.69.5.207])
	by ozlabs.org (Postfix) with ESMTP id 2CAD8679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 14:31:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C638F2.DA8C69DE"
Subject: RE: boot failure on lite5200b board
Date: Fri, 24 Feb 2006 11:31:52 +0800
Message-ID: <84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg><43FD6669.9090405@246tNt.com><84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg>
	<4b73d43f0602230818w63423513n817d9ec7eb580d2c@mail.gmail.com>
From: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
To: "John Rigby" <jcrigby@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C638F2.DA8C69DE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have actually tried both kernel with both console configurations. It =
gave the same output, thus I presume that the problem lies somewhere =
else. I attached the log to this email.=20

the board is Lite5200B Version 1.0. Which .config file do you want?

Sylvain, we have ordered a debugging set but we are still waiting for =
delivery, the leaking time is said to be one month, tant pis. And the =
log I attached here are booting from a higher address (0x500000).

My current u-boot args:
Autostarting. Press any key to abort..

Hit any key to stop autoboot:  0
=3D> printenv
baudrate=3D115200
autoload=3Dno
ethact=3DFEC ETHERNET
flshroot=3Droot=3D/dev/mtdblock2 rw
ethaddr=3D00:01:9F:00:27:2F
preboot=3Decho; echo Autostarting. Press any key to abort..; echo
bootdelay=3D5
hostname=3Dicecube
bootfile=3DMPC5200/uImage
nv=3Dnfsroot root=3D/dev/nfs rw nfsroot=3D10.190.3.113:/opt/eldk/rootfs
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff
nfsroot=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
bootcmd=3Drun net_nfs
filesize=3D546
fileaddr=3D500000
netmask=3D255.255.240.0
ipaddr=3D10.190.3.144
serverip=3D10.190.3.103
setconsole=3Dsetenv bootargs console=3DttyPSC0, 115200n8 console=3Dtty1
rootfs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs
bootargs=3Denv bootargs root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
flash_nfs=3Drun setconsole nfsargs addip;bootm
net_nfs=3Dtftp 500000 MPC5200/uImage;run setconsole nfsargs addip;bootm
nfsargs=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::offroo=
t=3D/dev/nfs rw
addip=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
ramargs=3Dsetenv bootargs root=3D/dev/ram rw
console=3Dconsole=3DttyS0,115200n8 console=3Dtty1
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Environment size: 1472/65532 bytes
=3D>                           =20




USING Sylvain's KERNEL:

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
Load address: 0x500000
Loading: =
#################################################################
         =
################################################################
done
Bytes transferred =3D 658114 (a0ac2 hex)
## Booting image at 00500000 ...
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



USING KERNEL FROM Freescale:

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
Load address: 0x500000
Loading: =
#################################################################
         =
#################################################################
         =
#################################################################
         =
#################################################################
         ###################################
done
Bytes transferred =3D 1510143 (170aff hex)
## Booting image at 00500000 ...
   Image Name:   Linux-2.6.11.7
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1510079 Bytes =3D  1.4 MB
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
ocp: exit
arch: exit



-----Original Message-----
From: John Rigby [mailto:jcrigby@gmail.com]
Sent: Fri 2/24/2006 0:18
To: #LI JIANGGAN#
Subject: Re: boot failure on lite5200b board
=20
If you are using Sylvain's kernel you need to set console=3DttyPSC0.  If =
you are
using a kernel from Freescale then you need to set console=3DttyS0.

Also what rev of the board do you have?



On 2/23/06, #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg> wrote:
>
>
> Thank you Jos=E9 Mar=EDa and Andrey for your advices, however the =
problem
> remains. I've tried setting the console (though I remember that our =
previous
> lite5200 board was working fine on kernel 2.4 without setting the =
console);
> meantime, I've set the booting image to 0x500000; I have also tried =
using
> the kernel image come together with the BSP, it's always the same =
error.
>
>  Sylvain, I've actually using your kernel source, the compiled image =
is
> around 700k (compared to the 1.4M image from the BSP), but it doesn't =
solve
> the problem. So I presume that the problem is lying somewhere else.
>
>  A SNAPSHOT OF THE BOOTING MESSAGES:
>
>
>  U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)
>
>  CPU:   MPC5200 v2.2 at 462 MHz
>         Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
>  Board: Freescale MPC5200 (Lite5200B)
>  I2C:   85 kHz, ready
>  DRAM:  256 MB
>  FLASH: 32 MB
>  PCI:   Bus Dev VenId DevId Class Int
>          00  1a  1057  5809  0680  00
>  In:    serial
>  Out:   serial
>  Err:   serial
>  Net:   FEC ETHERNET
>  IDE:   Bus 0: OK
>    Device 0: not available
>    Device 1: not available
>
>  Autostarting. Press any key to abort..
>
>  Hit any key to stop autoboot:  0
>  Using FEC ETHERNET device
>  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
>  Filename 'MPC5200/uImage'.
>  Load address: 0x100000
>  Loading:
> #################################################################
>
> ################################################################
>  done
>  Bytes transferred =3D 658114 (a0ac2 hex)
>  ## Booting image at 00100000 ...
>     Image Name:   Linux-2.6.16-rc1
>     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>     Data Size:    658050 Bytes =3D 642.6 kB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
>     Uncompressing Kernel Image ... OK
>  id mach(): done
>  MMU:enter
>  MMU:hw init
>  MMU:mapin
>  MMU:setio
>  MMU:exit
>  setup_arch: enter
>  setup_arch: bootmem
>  arch: exit
>
>
>  I am wondering whether it's a kernel problem or more likely to be a =
problem
> lying with the U-boot. It seems to hang when executing setup_arch()
> function, or maybe there is sth else behind the wall?
>
>  Regards,
>  Jianggan LI
>
>
>
>
>  -----Original Message-----
>  From: Sylvain Munaut [mailto:tnt@246tNt.com]
>  Sent: Thu 2/23/2006 15:38
>  To: #LI JIANGGAN#
>  Cc: linuxppc-embedded@ozlabs.org
>  Subject: Re: boot failure on lite5200b board
>
>  #LI JIANGGAN# wrote:
>  > Hello all,
>  >
>  > For my end-of-study project, I am working on an embedded system =
with
>  > reference of freescale's lite5200b reference board. I was trying to =
boot
>  > Linux 2.6.15 on the board (with the fec and bestcomm corrected). =
however
>  > the booting was stuck at the following stage:
>
>  In addition to what has already been said (use a higher address for =
the
>  image and don't forget console=3DttyPSC0 in kernel command line), =
make
>  sure you use the kernel from my git tree, it contains a few patches =
from
>  John Rigby to add support for the lite5200b.
>
>  Please report if it works, I've not been able to test those myself =
since
>  i'm still on lite5200.
>
>
>          Sylvain
>
>
>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>



------_=_NextPart_001_01C638F2.DA8C69DE
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
<TITLE>RE: boot failure on lite5200b board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I have actually tried both kernel with both console =
configurations. It gave the same output, thus I presume that the problem =
lies somewhere else. I attached the log to this email.<BR>
<BR>
the board is Lite5200B Version 1.0. Which .config file do you want?<BR>
<BR>
Sylvain, we have ordered a debugging set but we are still waiting for =
delivery, the leaking time is said to be one month, tant pis. And the =
log I attached here are booting from a higher address (0x500000).<BR>
<BR>
My current u-boot args:<BR>
Autostarting. Press any key to abort..<BR>
<BR>
Hit any key to stop autoboot:&nbsp; 0<BR>
=3D&gt; printenv<BR>
baudrate=3D115200<BR>
autoload=3Dno<BR>
ethact=3DFEC ETHERNET<BR>
flshroot=3Droot=3D/dev/mtdblock2 rw<BR>
ethaddr=3D00:01:9F:00:27:2F<BR>
preboot=3Decho; echo Autostarting. Press any key to abort..; echo<BR>
bootdelay=3D5<BR>
hostname=3Dicecube<BR>
bootfile=3DMPC5200/uImage<BR>
nv=3Dnfsroot root=3D/dev/nfs rw =
nfsroot=3D10.190.3.113:/opt/eldk/rootfs<BR>
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff<BR>
nfsroot=3Droot=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
bootcmd=3Drun net_nfs<BR>
filesize=3D546<BR>
fileaddr=3D500000<BR>
netmask=3D255.255.240.0<BR>
ipaddr=3D10.190.3.144<BR>
serverip=3D10.190.3.103<BR>
setconsole=3Dsetenv bootargs console=3DttyPSC0, 115200n8 =
console=3Dtty1<BR>
rootfs=3Droot=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs<BR>
bootargs=3Denv bootargs root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<BR=
>
flash_nfs=3Drun setconsole nfsargs addip;bootm<BR>
net_nfs=3Dtftp 500000 MPC5200/uImage;run setconsole nfsargs =
addip;bootm<BR>
nfsargs=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::offroo=
t=3D/dev/nfs rw<BR>
addip=3Dsetenv bootargs env bootargs root=3D/dev/nfs rw =
nfsroot=3D10.190.3.103:/opt/eldk-4-0/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<BR=
>
ramargs=3Dsetenv bootargs root=3D/dev/ram rw<BR>
console=3Dconsole=3DttyS0,115200n8 console=3Dtty1<BR>
stdin=3Dserial<BR>
stdout=3Dserial<BR>
stderr=3Dserial<BR>
<BR>
Environment size: 1472/65532 bytes<BR>
=3D&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;<BR>
<BR>
<BR>
<BR>
<BR>
USING Sylvain's KERNEL:<BR>
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
Load address: 0x500000<BR>
Loading: =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
################################################################<BR>
done<BR>
Bytes transferred =3D 658114 (a0ac2 hex)<BR>
## Booting image at 00500000 ...<BR>
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
<BR>
<BR>
USING KERNEL FROM Freescale:<BR>
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
Load address: 0x500000<BR>
Loading: =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
###################################<BR>
done<BR>
Bytes transferred =3D 1510143 (170aff hex)<BR>
## Booting image at 00500000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.11.7<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1510079 Bytes =3D&nbsp; 1.4 =
MB<BR>
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
ocp: exit<BR>
arch: exit<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: John Rigby [<A =
HREF=3D"mailto:jcrigby@gmail.com">mailto:jcrigby@gmail.com</A>]<BR>
Sent: Fri 2/24/2006 0:18<BR>
To: #LI JIANGGAN#<BR>
Subject: Re: boot failure on lite5200b board<BR>
<BR>
If you are using Sylvain's kernel you need to set =
console=3DttyPSC0.&nbsp; If you are<BR>
using a kernel from Freescale then you need to set console=3DttyS0.<BR>
<BR>
Also what rev of the board do you have?<BR>
<BR>
<BR>
<BR>
On 2/23/06, #LI JIANGGAN# &lt;lijianggan@pmail.ntu.edu.sg&gt; wrote:<BR>
&gt;<BR>
&gt;<BR>
&gt; Thank you Jos=E9 Mar=EDa and Andrey for your advices, however the =
problem<BR>
&gt; remains. I've tried setting the console (though I remember that our =
previous<BR>
&gt; lite5200 board was working fine on kernel 2.4 without setting the =
console);<BR>
&gt; meantime, I've set the booting image to 0x500000; I have also tried =
using<BR>
&gt; the kernel image come together with the BSP, it's always the same =
error.<BR>
&gt;<BR>
&gt;&nbsp; Sylvain, I've actually using your kernel source, the compiled =
image is<BR>
&gt; around 700k (compared to the 1.4M image from the BSP), but it =
doesn't solve<BR>
&gt; the problem. So I presume that the problem is lying somewhere =
else.<BR>
&gt;<BR>
&gt;&nbsp; A SNAPSHOT OF THE BOOTING MESSAGES:<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp; U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<BR>
&gt;<BR>
&gt;&nbsp; CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 MHz<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, IPB =
132 MHz, PCI 33 MHz<BR>
&gt;&nbsp; Board: Freescale MPC5200 (Lite5200B)<BR>
&gt;&nbsp; I2C:&nbsp;&nbsp; 85 kHz, ready<BR>
&gt;&nbsp; DRAM:&nbsp; 256 MB<BR>
&gt;&nbsp; FLASH: 32 MB<BR>
&gt;&nbsp; PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; =
1a&nbsp; 1057&nbsp; 5809&nbsp; 0680&nbsp; 00<BR>
&gt;&nbsp; In:&nbsp;&nbsp;&nbsp; serial<BR>
&gt;&nbsp; Out:&nbsp;&nbsp; serial<BR>
&gt;&nbsp; Err:&nbsp;&nbsp; serial<BR>
&gt;&nbsp; Net:&nbsp;&nbsp; FEC ETHERNET<BR>
&gt;&nbsp; IDE:&nbsp;&nbsp; Bus 0: OK<BR>
&gt;&nbsp;&nbsp;&nbsp; Device 0: not available<BR>
&gt;&nbsp;&nbsp;&nbsp; Device 1: not available<BR>
&gt;<BR>
&gt;&nbsp; Autostarting. Press any key to abort..<BR>
&gt;<BR>
&gt;&nbsp; Hit any key to stop autoboot:&nbsp; 0<BR>
&gt;&nbsp; Using FEC ETHERNET device<BR>
&gt;&nbsp; TFTP from server 10.190.3.103; our IP address is =
10.190.3.144<BR>
&gt;&nbsp; Filename 'MPC5200/uImage'.<BR>
&gt;&nbsp; Load address: 0x100000<BR>
&gt;&nbsp; Loading:<BR>
&gt; =
#################################################################<BR>
&gt;<BR>
&gt; =
################################################################<BR>
&gt;&nbsp; done<BR>
&gt;&nbsp; Bytes transferred =3D 658114 (a0ac2 hex)<BR>
&gt;&nbsp; ## Booting image at 00100000 ...<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.16-rc1<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux =
Kernel Image (gzip compressed)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =
=3D 642.6 kB<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Load Address: 00000000<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
&gt;&nbsp; id mach(): done<BR>
&gt;&nbsp; MMU:enter<BR>
&gt;&nbsp; MMU:hw init<BR>
&gt;&nbsp; MMU:mapin<BR>
&gt;&nbsp; MMU:setio<BR>
&gt;&nbsp; MMU:exit<BR>
&gt;&nbsp; setup_arch: enter<BR>
&gt;&nbsp; setup_arch: bootmem<BR>
&gt;&nbsp; arch: exit<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp; I am wondering whether it's a kernel problem or more likely =
to be a problem<BR>
&gt; lying with the U-boot. It seems to hang when executing =
setup_arch()<BR>
&gt; function, or maybe there is sth else behind the wall?<BR>
&gt;<BR>
&gt;&nbsp; Regards,<BR>
&gt;&nbsp; Jianggan LI<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp; -----Original Message-----<BR>
&gt;&nbsp; From: Sylvain Munaut [<A =
HREF=3D"mailto:tnt@246tNt.com">mailto:tnt@246tNt.com</A>]<BR>
&gt;&nbsp; Sent: Thu 2/23/2006 15:38<BR>
&gt;&nbsp; To: #LI JIANGGAN#<BR>
&gt;&nbsp; Cc: linuxppc-embedded@ozlabs.org<BR>
&gt;&nbsp; Subject: Re: boot failure on lite5200b board<BR>
&gt;<BR>
&gt;&nbsp; #LI JIANGGAN# wrote:<BR>
&gt;&nbsp; &gt; Hello all,<BR>
&gt;&nbsp; &gt;<BR>
&gt;&nbsp; &gt; For my end-of-study project, I am working on an embedded =
system with<BR>
&gt;&nbsp; &gt; reference of freescale's lite5200b reference board. I =
was trying to boot<BR>
&gt;&nbsp; &gt; Linux 2.6.15 on the board (with the fec and bestcomm =
corrected). however<BR>
&gt;&nbsp; &gt; the booting was stuck at the following stage:<BR>
&gt;<BR>
&gt;&nbsp; In addition to what has already been said (use a higher =
address for the<BR>
&gt;&nbsp; image and don't forget console=3DttyPSC0 in kernel command =
line), make<BR>
&gt;&nbsp; sure you use the kernel from my git tree, it contains a few =
patches from<BR>
&gt;&nbsp; John Rigby to add support for the lite5200b.<BR>
&gt;<BR>
&gt;&nbsp; Please report if it works, I've not been able to test those =
myself since<BR>
&gt;&nbsp; i'm still on lite5200.<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sylvain<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; _______________________________________________<BR>
&gt; Linuxppc-embedded mailing list<BR>
&gt; Linuxppc-embedded@ozlabs.org<BR>
&gt; <A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
&gt;<BR>
&gt;<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C638F2.DA8C69DE--
