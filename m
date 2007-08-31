Return-Path: <josel_am2@yahoo.es>
Received: from web25715.mail.ukl.yahoo.com (web25715.mail.ukl.yahoo.com
	[217.12.10.57]) by ozlabs.org (Postfix) with SMTP id 6B504DDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Sep 2007 02:26:55 +1000 (EST)
Date: Fri, 31 Aug 2007 16:20:13 +0000 (GMT)
From: =?iso-8859-1?Q?Jos=E9_Luis_A=F1amuro?= <josel_am2@yahoo.es>
Subject: Help linuxppc-2.4.26
To: ammubhai@gmail.com
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1545552355-1188577213=:69023"
Message-ID: <519831.69023.qm@web25715.mail.ukl.yahoo.com>
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

--0-1545552355-1188577213=:69023
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi =0AI am Jose Luis.  I am compilling the kernel linuxppc-2.4.26. First I =
use the bitkepper to retrieve the version of kernel after I path it with Ba=
se Support Package (BSP) generated in EDK 8.2i, after I run "make oldconfig=
" to import the config file for the ML310, then I run "make menuconfig" whe=
n i set specifically changed from ml310, after i run "make dep", "make zIma=
ge" and .... appears a strange error that says:=0A=0Amake[1]: se ingresa al=
 directorio `/home/jose/bk-client2.0/linuxppc-2.4.26/arch/ppc/4xx_io'=0Amak=
e all_targets=0Amake[2]: se ingresa al directorio `/home/jose/bk-client2.0/=
linuxppc-2.4.26/arch/ppc/4xx_io'=0Amake[2]: No se hace nada para `all_targe=
ts'.=0Amake[2]: se sale del directorio `/home/jose/bk-client2.0/linuxppc-2.=
4.26/arch/ppc/4xx_io'=0Amake[1]: se sale del directorio `/home/jose/bk-clie=
nt2.0/linuxppc-2.4.26/arch/ppc/4xx_io'=0Apowerpc-405-linux-gnu-ld -T arch/p=
pc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head_4xx.o init/m=
ain.o init/version.o init/do_mounts.o \=0A                --start-group \=
=0A                arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o a=
rch/ppc/mm/mm.o arch/ppc/lib/li b.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc=
.o \=0A                 drivers/char/char.o drivers/block/block.o drivers/m=
isc/misc.o drivers/net/net.o  drive rs/macintosh/macintosh.o drivers/media/=
media.o arch/ppc/4xx_io/4xx_io.o \=0A                net/network.o \=0A    =
            /home/jose/bk-client2.0/linuxppc-2.4.26/lib/lib.a \=0A         =
       --end-group \=0A                -o vmlinux=0Adrivers/block/block.o(.=
text.init+0x6c8): In function `xsysace_init':=0A: undefined reference to `X=
SysAce_Initialize'=0Amake: *** [vmlinux] Error 1=0A=0APlease i hope so you =
can help me, I carry many days with it and I do not know how resolv it=0A=
=0ABest Regards=0AJos=E9 Luis=0A=0A=0A=0A=0A      _________________________=
_____________________ =0AS=E9 un Mejor Viajero                             =
         =0A=BFQuieres saber c=F3mo? =A1Deja que otras personas te ayuden!=
=0Ahttp://advision.webevents.yahoo.com/reto/viaje.html
--0-1545552355-1188577213=:69023
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>Hi <br>I am Jose Luis.&nbsp; I am compilling the kerne=
l linuxppc-2.4.26. First I use the bitkepper to retrieve the version of ker=
nel after I path it with Base Support Package (BSP) generated in EDK 8.2i, =
after I run "make oldconfig" to import the config file for the ML310, then =
I run "make menuconfig" when i set specifically changed from ml310, after i=
 run "make dep", "make zImage" and .... appears a strange error that says:<=
br><br>make[1]: se ingresa al directorio `/home/jose/bk-client2.0/linuxppc-=
2.4.26/arch/ppc/4xx_io'<br>make all_targets<br>make[2]: se ingresa al direc=
torio `/home/jose/bk-client2.0/linuxppc-2.4.26/arch/ppc/4xx_io'<br>make[2]:=
 No se hace nada para `all_targets'.<br>make[2]: se sale del directorio `/h=
ome/jose/bk-client2.0/linuxppc-2.4.26/arch/ppc/4xx_io'<br>make[1]: se
 sale del directorio `/home/jose/bk-client2.0/linuxppc-2.4.26/arch/ppc/4xx_=
io'<br>powerpc-405-linux-gnu-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -=
Bstatic arch/ppc/kernel/head_4xx.o init/main.o init/version.o init/do_mount=
s.o \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; --start-group \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/ppc/kernel=
/kernel.o arch/ppc/platforms/platform.o arch/ppc/mm/mm.o arch/ppc/lib/li b.=
o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driv=
ers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o=
&nbsp; drive rs/macintosh/macintosh.o drivers/media/media.o arch/ppc/4xx_io=
/4xx_io.o \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; net/network.o
 \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /home/jose/bk-client2.0/linuxppc-2.4.26/lib/lib.a \<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; --end-group \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o vmlinux<br>drivers/bl=
ock/block.o(.text.init+0x6c8): In function `xsysace_init':<br>: undefined r=
eference to `XSysAce_Initialize'<br>make: *** [vmlinux] Error 1<br><br>Plea=
se i hope so you can help me, I carry many days with it and I do not know h=
ow resolv it<br><br>Best Regards<br>Jos=E9 Luis<br></div></div><br>=0A=0A=
=0A      <hr size=3D1><br><font face=3D"Verdana" size=3D"-2">S=E9 un Mejor =
Viajero<br>=BFQuieres saber c=F3mo? <a href=3D"http://us.rd.yahoo.com/mail/=
es/tagline/beabetter/* http://advision.webevents.yahoo.com/reto/entretenimi=
ento.html">=A1Deja que otras personas te ayuden! </a>.<br></font></body></h=
tml>
--0-1545552355-1188577213=:69023--
