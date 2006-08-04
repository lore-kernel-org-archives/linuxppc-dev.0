Return-Path: <Prashant.Yendigeri@lntinfotech.com>
Received: from mail42.messagelabs.com (mail42.messagelabs.com [216.82.244.163])
	by ozlabs.org (Postfix) with SMTP id 1845D67B55
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 21:02:47 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: Trouble booting Kernel 2.6.12 on powerpc 8540
MIME-Version: 1.0
Message-ID: <OF4A51FDA9.E90D3BFF-ON652571C0.003BB60B-652571C0.003CAB7A@lntinfotech.com>
From: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
Date: Fri, 4 Aug 2006 16:32:40 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 003CAB76652571C0_="
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
--=_alternative 003CAB76652571C0_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

I=20am=20able=20to=20boot=20linux=20kernel=202.6.12=20on=20ppc=208540,=20a=
nd=20also=20able=20to=20login=20
too.=20But=20then=20i=20am=20unable=20to=20see=20any=20output=20=20when=20=
i=20say=20ls,=20mount,ifconfig=20
etc.=20Only=20pwd=20and=20env=20seem=20to=20work
Whereas=20if=20i=20boot=20with=20kernel=202.4.20=20and=20with=20the=20same=
=20ramdisk=20which=20i=20
used=20to=20boot=202.6.12,=20i=20am=20able=20to=20see=20eveything,=20ls,=20=
mount=20outputs=20etc.

I=20built=20the=20ramdisk=20image=20using=20busybox=201.2=20

This=20is=20the=20boot=20messages=20of=202.6.12=20:
##=20Booting=20image=20at=2001000000=20...
=20=20=20Image=20Name:=20=20=20Linux-2.6.12
=20=20=20Image=20Type:=20=20=20PowerPC=20Linux=20Kernel=20Image=20(gzip=20=
compressed)
=20=20=20Data=20Size:=20=20=20=201177413=20Bytes=20=3D=20=201.1=20MB
=20=20=20Load=20Address:=2000000000
=20=20=20Entry=20Point:=20=20000000000
=20=20=20Verifying=20ksum=20...=20OK
=20=20=20Uncompressing=20Kernel=20Image=20...=20OK
##=20Loading=20RAMDisk=20Image=20at=2001200000=20...
=20=20=20Image=20Name:=20=20=20MPC85xx=20ramdisk
=20=20=20Image=20Type:=20=20=20PowerPC=20Linux=20RAMDisk=20Image=20(gzip=20=
compressed)
=20=20=20Data=20Size:=20=20=20=205887861=20Bytes=20=3D=20=205.6=20MB
=20=20=20Load=20Address:=2000000000
=20=20=20Entry=20Point:=20=2000000000
=20=20=20Verifying=20Checksum=20...=20OK
=20=20=20Loading=20Ramdisk=20to=200fa16000,=20end=200ffb3775=20...=20OK
mpc8540ads_init():=20exit
id=20mach():=20done
MMU:enter
MMU:hw=20init
MMU:mapin
MMU:setio
MMU:exit
setup_arch:=20enter
setup_arch:=20bootmem
mpc8540ads_setup_arch()
arch:=20exit
openpic:=20enter
=20=20=20=20=20=20=20=20=20=20=20=20=20r=20=20=20=20=20=20...?.?....=C9=A5=
?..)55?....?.?..???)5?
]=20class_hotplug=20-=20name=20=3D=20ttyw8
[=20=20=20=202.126538]=20Generic=20RTC=20Driver=20v1.07
[=20=20=20=202.127108]=20Serial:=208250/16550=20driver=20$Revision:=201.90=
=20$=204=20ports,=20IRQ=20
sharind[=20=20=20=202.130813]=20ttyS0=20at=20MMIO=200xe0004500=20(irq=20=3D=
=2026)=20is=20a=2016550A
[=20=20=20=202.152265]=20ttyS1=20at=20MMIO=200xe0004600=20(irq=20=3D=2026)=
=20is=20a=2016550A
[=20=20=20=202.158526]=20io=20scheduler=20noop=20registered
[=20=20=20=202.162574]=20io=20scheduler=20anticipatory=20registered
[=20=20=20=202.167318]=20io=20scheduler=20deadline=20registered
[=20=20=20=202.171730]=20io=20scheduler=20cfq=20registered
[=20=20=20=202.182339]=20RAMDISK=20driver=20initialized:=2016=20RAM=20disk=
s=20of=2032768K=20size=20
1024=20ble[=20=20=20=202.193524]=20loop:=20loaded=20(max=208=20devices)
[=20=20=20=202.198105]=20Equalizer2002:=20Simon=20Janes=20(simon@ncm.com)=20=
and=20David=20S.=20
Miller=20)[=20=20=20=202.207423]=20tun:=20Universal=20TUN/TAP=20device=20d=
river,=201.6
[=20=20=20=202.212597]=20tun:=20(C)=201999-2004=20Max=20Krasnyansky=20<max=
k@qualcomm.com>
[=20=20=20=202.219737]=20mice:=20PS/2=20mouse=20device=20common=20for=20al=
l=20mice
[=20=20=20=202.225711]=20i2c=20/dev=20entries=20driver
[=20=20=20=202.230856]=20NET:=20Registered=20protocol=20family=202
[=20=20=20=202.245261]=20IP:=20routing=20cache=20hash=20table=20of=202048=20=
buckets,=2016Kbytes
[=20=20=20=202.252570]=20TCP=20established=20hash=20table=20entries:=20163=
84=20(order:=205,=20131072=20
byt)[=20=20=20=202.260355]=20TCP=20bind=20hash=20table=20entries:=2016384=20=
(order:=204,=2065536=20
bytes)
[=20=20=20=202.267366]=20TCP:=20Hash=20tables=20configured=20(established=20=
16384=20bind=2016384)
[=20=20=20=202.274459]=20NET:=20Registered=20protocol=20family=201
[=20=20=20=202.278943]=20NET:=20Registered=20protocol=20family=2017
[=20=20=20=202.284791]=20RAMDISK:=20Compressed=20image=20found=20at=20bloc=
k=200
[=20=20=20=204.435668]=20VFS:=20Mounted=20root=20(ext2=20filesystem).
[=20=20=20=204.440693]=20Freeing=20unused=20kernel=20memory:=2084k=20init
[=20=20=20=204.445614]=20Reached=20here
[=20=20=20=204.448201]=20Reached=20here=202
[=20=20=20=204.451423]=20Reached=20here=203
[=20=20=20=204.454196]=20going=20to=20Exec=20/sbin/init
init=20started:=20=20BusyBox=20v1.2.0=20(2006.08.02-10:51+0000)=20multi-ca=
ll=20binary
Starting=20pid=20682,=20console=20/dev/ttyS0:=20'/etc/init.d/rcS'
Starting=20pid=20690,=20console=20/dev/ttyS0:=20'/sbin/ge
Welcome=20to=20Linux=20on=20MPC85xxSK=20board!
MPC85xxSK=20login:


->=20After=20this=20i=20login=20as=20root=20and=20type=20ls=20but=20no=20o=
utput=20on=20the=20screen,=20pwd=20
and=20env=20throw=20output.



Thanks=20and=20Regards,
Prashant=20



______________________________________________________________________
--=_alternative 003CAB76652571C0_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="ISO-8859-1"


<br><font=20size=3D2=20face=3D"sans-serif">Hi,</font>
<br>
<br><font=20size=3D2=20face=3D"sans-serif">I=20am=20able=20to=20boot=20lin=
ux=20kernel=202.6.12
on=20ppc=208540,=20and=20also=20able=20to=20login=20too.=20But=20then=20i=20=
am=20unable=20to=20see=20any
output=20&nbsp;when=20i=20say=20ls,=20mount,ifconfig=20etc.=20Only=20pwd=20=
and=20env=20seem=20to
work</font>
<br><font=20size=3D2=20face=3D"sans-serif">Whereas=20if=20i=20boot=20with=20=
kernel=202.4.20
and=20with=20the=20same=20ramdisk=20which=20i=20used=20to=20boot=202.6.12,=
=20i=20am=20able=20to=20see
eveything,=20ls,=20mount=20outputs=20etc.</font>
<br>
<br><font=20size=3D2=20face=3D"sans-serif">I=20built=20the=20ramdisk=20ima=
ge=20using=20busybox
1.2=20&nbsp;</font>
<br>
<br><font=20size=3D2=20face=3D"sans-serif">This=20is=20the=20boot=20messag=
es=20of=202.6.12
:</font>
<br><font=20size=3D2=20face=3D"sans-serif">##=20Booting=20image=20at=20010=
00000=20...</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Image=20Name:=20=
&nbsp;=20Linux-2.6.12</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Image=20Type:=20=
&nbsp;=20PowerPC
Linux=20Kernel=20Image=20(gzip=20compressed)</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Data=20Size:=20&=
nbsp;=20&nbsp;1177413
Bytes=20=3D=20&nbsp;1.1=20MB</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Load=20Address:=20=
00000000</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Entry=20Point:=20=
&nbsp;000000000</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Verifying=20ksum=
=20...=20OK</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Uncompressing=20=
Kernel=20Image
...=20OK</font>
<br><font=20size=3D2=20face=3D"sans-serif">##=20Loading=20RAMDisk=20Image=20=
at=2001200000
...</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Image=20Name:=20=
&nbsp;=20MPC85xx
ramdisk</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Image=20Type:=20=
&nbsp;=20PowerPC
Linux=20RAMDisk=20Image=20(gzip=20compressed)</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Data=20Size:=20&=
nbsp;=20&nbsp;5887861
Bytes=20=3D=20&nbsp;5.6=20MB</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Load=20Address:=20=
00000000</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Entry=20Point:=20=
&nbsp;00000000</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Verifying=20Chec=
ksum=20...
OK</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;Loading=20Ramdis=
k=20to=200fa16000,
end=200ffb3775=20...=20OK</font>
<br><font=20size=3D2=20face=3D"sans-serif">mpc8540ads_init():=20exit</font=
>
<br><font=20size=3D2=20face=3D"sans-serif">id=20mach():=20done</font>
<br><font=20size=3D2=20face=3D"sans-serif">MMU:enter</font>
<br><font=20size=3D2=20face=3D"sans-serif">MMU:hw=20init</font>
<br><font=20size=3D2=20face=3D"sans-serif">MMU:mapin</font>
<br><font=20size=3D2=20face=3D"sans-serif">MMU:setio</font>
<br><font=20size=3D2=20face=3D"sans-serif">MMU:exit</font>
<br><font=20size=3D2=20face=3D"sans-serif">setup_arch:=20enter</font>
<br><font=20size=3D2=20face=3D"sans-serif">setup_arch:=20bootmem</font>
<br><font=20size=3D2=20face=3D"sans-serif">mpc8540ads_setup_arch()</font>
<br><font=20size=3D2=20face=3D"sans-serif">arch:=20exit</font>
<br><font=20size=3D2=20face=3D"sans-serif">openpic:=20enter</font>
<br><font=20size=3D2=20face=3D"sans-serif">&nbsp;=20&nbsp;=20&nbsp;=20&nbs=
p;=20&nbsp;=20&nbsp;
&nbsp;r=20&nbsp;=20&nbsp;=20&nbsp;...?.?....=C9=A5?..)55?....?.?..???)5?</=
font>
<br><font=20size=3D2=20face=3D"sans-serif">]=20class_hotplug=20-=20name=20=
=3D=20ttyw8</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.126538]=20=
Generic=20RTC
Driver=20v1.07</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.127108]=20=
Serial:=208250/16550
driver=20$Revision:=201.90=20$=204=20ports,=20IRQ=20sharind[=20&nbsp;=20&n=
bsp;2.130813]=20ttyS0
at=20MMIO=200xe0004500=20(irq=20=3D=2026)=20is=20a=2016550A</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.152265]=20=
ttyS1=20at=20MMIO
0xe0004600=20(irq=20=3D=2026)=20is=20a=2016550A</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.158526]=20=
io=20scheduler
noop=20registered</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.162574]=20=
io=20scheduler
anticipatory=20registered</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.167318]=20=
io=20scheduler
deadline=20registered</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.171730]=20=
io=20scheduler
cfq=20registered</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.182339]=20=
RAMDISK=20driver
initialized:=2016=20RAM=20disks=20of=2032768K=20size=201024=20ble[=20&nbsp=
;=20&nbsp;2.193524]
loop:=20loaded=20(max=208=20devices)</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.198105]=20=
Equalizer2002:
Simon=20Janes=20(simon@ncm.com)=20and=20David=20S.=20Miller=20)[=20&nbsp;=20=
&nbsp;2.207423]
tun:=20Universal=20TUN/TAP=20device=20driver,=201.6</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.212597]=20=
tun:=20(C)=201999-2004
Max=20Krasnyansky=20&lt;maxk@qualcomm.com&gt;</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.219737]=20=
mice:=20PS/2
mouse=20device=20common=20for=20all=20mice</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.225711]=20=
i2c=20/dev=20entries
driver</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.230856]=20=
NET:=20Registered
protocol=20family=202</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.245261]=20=
IP:=20routing
cache=20hash=20table=20of=202048=20buckets,=2016Kbytes</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.252570]=20=
TCP=20established
hash=20table=20entries:=2016384=20(order:=205,=20131072=20byt)[=20&nbsp;=20=
&nbsp;2.260355]
TCP=20bind=20hash=20table=20entries:=2016384=20(order:=204,=2065536=20byte=
s)</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.267366]=20=
TCP:=20Hash=20tables
configured=20(established=2016384=20bind=2016384)</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.274459]=20=
NET:=20Registered
protocol=20family=201</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.278943]=20=
NET:=20Registered
protocol=20family=2017</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;2.284791]=20=
RAMDISK:=20Compressed
image=20found=20at=20block=200</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;4.435668]=20=
VFS:=20Mounted
root=20(ext2=20filesystem).</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;4.440693]=20=
Freeing=20unused
kernel=20memory:=2084k=20init</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;4.445614]=20=
Reached=20here</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;4.448201]=20=
Reached=20here
2</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;4.451423]=20=
Reached=20here
3</font>
<br><font=20size=3D2=20face=3D"sans-serif">[=20&nbsp;=20&nbsp;4.454196]=20=
going=20to=20Exec
/sbin/init</font>
<br><font=20size=3D2=20face=3D"sans-serif">init=20started:=20&nbsp;BusyBox=
=20v1.2.0=20(2006.08.02-10:51+0000)
multi-call=20binary</font>
<br><font=20size=3D2=20face=3D"sans-serif">Starting=20pid=20682,=20console=
=20/dev/ttyS0:
'/etc/init.d/rcS'</font>
<br><font=20size=3D2=20face=3D"sans-serif">Starting=20pid=20690,=20console=
=20/dev/ttyS0:
'/sbin/ge</font>
<br><font=20size=3D2=20face=3D"sans-serif">Welcome=20to=20Linux=20on=20MPC=
85xxSK=20board!</font>
<br><font=20size=3D2=20face=3D"sans-serif">MPC85xxSK=20login:</font>
<br>
<br>
<br><font=20size=3D2=20face=3D"sans-serif">-&gt;=20After=20this=20i=20logi=
n=20as=20root=20and
type=20ls=20but=20no=20output=20on=20the=20screen,=20pwd=20and=20env=20thr=
ow=20output.</font>
<br>
<br>
<br>
<br><font=20size=3D2=20face=3D"sans-serif">Thanks=20and=20Regards,</font>
<br><font=20size=3D2=20face=3D"sans-serif">Prashant=20</font>
<br>
<br>
<br>
<BR>
______________________________________________________________________<BR>=


--=_alternative 003CAB76652571C0_=--
