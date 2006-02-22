Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3AD4E67A39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Feb 2006 19:25:06 +1100 (EST)
Date: Wed, 22 Feb 2006 11:24:52 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <185650861.20060222112453@varma-el.com>
To: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
Subject: Re: boot failure on lite5200b board
In-Reply-To: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Andrey Volkov <avolkov@varma-el.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Jianggan.

On Wednesday, February 22, 2006, #LI JIANGGAN# wrote:

>   =20
>   =20
> Hello all,
> =20
>  For my end-of-study project, I am working on an embedded system
> with reference of freescale's lite5200b reference board. I was
> trying to boot Linux 2.6.15 on the board (with the fec and bestcomm
> corrected). however the booting was stuck at the following stage:
>  U-Boot 1.1.3 (Feb=A0 6 2006 - 09:56:46)
> =20
>  ## Booting image at 00100000 ...
>  =A0=A0 Image Name:=A0=A0 Linux-2.6.16-rc1
>  =A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)
>  =A0=A0 Data Size:=A0=A0=A0 658050 Bytes =3D 642.6 kB
>  =A0=A0 Load Address: 00000000
>  =A0=A0 Entry Point:=A0 00000000
>  =A0=A0 Verifying Checksum ... OK
>  =A0=A0 Uncompressing Kernel Image ... OK
>  id mach(): done
>  MMU:enter
>  MMU:hw init
>  MMU:mapin
>  MMU:setio
>  MMU:exit
>  setup_arch: enter
>  setup_arch: bootmem
>  arch: exit
> =20
>  I think it's probably the problem of kernel configuration prior to
> compilation. Has anybody got 2.6 kernel working probably lite5200b?
> =20
>  THE U-BOOT ENVIRONMENT SETTINGS:
> =20
>  =3D> printenv
>  baudrate=3D115200
>  autoload=3Dno
>  ethact=3DFEC ETHERNET
>  preboot=3Decho;echo Autostarting. Press any key to abort..;echo
>  bootdelay=3D5
>  hostname=3Dicecube
>  flshroot=3Droot=3D/dev/mtdblock2 rw
>  ethaddr=3D00:01:9F:00:27:2F
>  rootfs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
>  filesize=3Df2
>  fileaddr=3D100000
>  netmask=3D255.255.240.0
>  serverip=3D10.190.3.103
>  bootcmd=3Dtftp; bootm
>  bootfile=3DMPC5200/uImage
>  ipaddr=3D10.190.3.144
>=20
> ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff
>  nfsroot=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
>  bootargs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
> ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
>  stdin=3Dserial
>  stdout=3Dserial
>  stderr=3Dserial
> =20
>  Environment size: 704/65532 bytes
>  =3D>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> =20
>  THE WHLOE BOOTING MESSAGE:
> =20
>  U-Boot 1.1.3 (Feb=A0 6 2006 - 09:56:46)
> =20
>  CPU:=A0=A0 MPC5200 v2.2 at 462 MHz
>  =A0=A0=A0=A0=A0=A0 Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
>  Board: Freescale MPC5200 (Lite5200B)
>  I2C:=A0=A0 85 kHz, ready
>  DRAM:=A0 256 MB
>  FLASH: 32 MB
>  PCI:=A0=A0 Bus Dev VenId DevId Class Int
>  =A0=A0=A0=A0=A0=A0=A0 00=A0 1a=A0 1057=A0 5809=A0 0680=A0 00
>  In:=A0=A0=A0 serial
>  Out:=A0=A0 serial
>  Err:=A0=A0 serial
>  Net:=A0=A0 FEC ETHERNET
>  IDE:=A0=A0 Bus 0: OK
>  =A0 Device 0: not available
>  =A0 Device 1: not available
> =20
>  Autostarting. Press any key to abort..
> =20
>  Hit any key to stop autoboot:=A0 0
>  Using FEC ETHERNET device
>  TFTP from server 10.190.3.103; our IP address is 10.190.3.144
>  Filename 'MPC5200/uImage'.
>  Load address: 0x100000
>  Loading:
> #################################################################
>  =A0=A0=A0=A0=A0=A0=A0=A0
> ################################################################
>  done
>  Bytes transferred =3D 658114 (a0ac2 hex)
>  ## Booting image at 00100000 ...
>  =A0=A0 Image Name:=A0=A0 Linux-2.6.16-rc1
>  =A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)
>  =A0=A0 Data Size:=A0=A0=A0 658050 Bytes =3D 642.6 kB
>  =A0=A0 Load Address: 00000000
>  =A0=A0 Entry Point:=A0 00000000
>  =A0=A0 Verifying Checksum ... OK
>  =A0=A0 Uncompressing Kernel Image ... OK
>  id mach(): done
>  MMU:enter
>  MMU:hw init
>  MMU:mapin
>  MMU:setio
>  MMU:exit
>  setup_arch: enter
>  setup_arch: bootmem
>  arch: exit
> =20
>  Thanks.
> =20
>  Jianggan LI
> =20
>  =20
>  =20
>   =20
First, please DON'T use html in mails, which is addressed to mail
lists.
Now about your problem: you're doesn't setup ttyPSC0 as console device
for the kernel (as I understand, above is snapshot of terminal
output, am I right?).
Add string like this: console=3DttyPSC0,115200n8 console=3Dtty1 to the kern=
el parameters
(as simple hack you could add above string to rootfs enviroment
variable).

As example, here is part of our board config (not lite5200B):

baudrate=3D115200
preboot=3Decho;echo Type "run flash_nfs" to mount root filesystem over NFS;=
echo
netdev=3Deth0
addip=3Dsetenv bootargs $(bootargs)
ip=3D$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):of=
f panic=3D5
ethact=3DFEC ETHERNET
serverip=3D10.0.19.228
gatewayip=3D10.0.19.238
netmask=3D255.255.255.0
rootpath=3D/tftpboot/10.0.19.6
ipaddr=3D10.0.19.6
ntpserverip=3D10.0.19.238
ramargs=3Dsetenv bootargs root=3D/dev/ram rw
net_nfs=3Dtftp 200000 $(bootfile);run setconsole nfsargs addip;bootm
setconsole=3Dsetenv bootargs $(console)
nfsargs=3Dsetenv bootargs $(bootargs) root=3D/dev/nfs rw nfsroot=3D$(server=
ip):$(rootpath)
kernel_addr=3DFE040000
flash_root=3Dtftp 200000 $(bootfile);run setconsole jffs2rootfs addip;bootm
flash_self=3Drun setconsole jffs2rootfs addip;bootm $(kernel_addr)
jffs2rootfs=3Dsetenv bootargs $(bootargs) rootfstype=3Djffs2 root=3D31:2 rw
bootfile=3D/tftpboot/uImage.vec5200
hostname=3Dvec5200-3
bootdelay=3D1
console=3Dconsole=3DttyPSC0,115200n8 console=3Dtty1
flash_nfs=3Drun setconsole nfsargs addip;bootm $(kernel_addr)
tnote_cfg=3Dsetenv serverip 10.0.19.4;setenv gatewayip 10.0.19.4
net_nfs_tnote=3Drun tnote_cfg;run net_nfs
bootcmd=3Drun net_nfs
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial


--=20
Regards,
Andrey Volkov
