Return-Path: <spyrek3@o2.pl>
Received: from tur.go2.pl (tur.go2.pl [193.17.41.50])
	by ozlabs.org (Postfix) with ESMTP id DAB02DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 02:52:34 +1000 (EST)
Received: from rekin23.go2.pl (rekin23.go2.pl [193.17.41.16])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id 67D0A2301BC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 18:35:43 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.137])
	by rekin23.go2.pl (Postfix) with SMTP id 12132128866
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 18:35:36 +0200 (CEST)
Subject: =?UTF-8?Q?RE:_Linux_w/ML403_PLB_TEMAC?=
From: =?UTF-8?Q?Jarek?= <spyrek3@o2.pl>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Message-ID: <514df87a.324e3d40.461a6b58.edd0@o2.pl>
Date: Mon, 09 Apr 2007 18:35:36 +0200
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello=20folks,

I=20have=20been=20working=20for=20a=20while=20on=20bringing=20up=20PLB=20=
Temac=20on=20ml403.=20I=20have=20followed=20all=20steps=20presented=20by=20=
Glenn,=20but=20unfortunately=20I=20have=20stacked=20in=20one=20place.=20I=
=20hope=20that=20maybe=20one=20of=20you=20due=20to=20your=20experince=20c=
an=20give=20me=20some=20advice.=20I=20use=20systemace=20for=20mounting=20=
rfs=20and=20I=20have=20patched=20my=20kernel=20with=20Paulus=20Temac=20pa=
tches.=20Kernel=20compiles=20without=20any=20problem.=20As=20i=20said=20i=
=20followed=20Glenn's=20steps=20for=20configuring=20kernel=20with=20plb/t=
emac.=20The=20only=20difference=20I=20have=20noticed=20is=20that=20I=20us=
e=20root=20file=20system=20on=20a=20flash=20card.=20After=20booting=20the=
=20kernel=20from=20flash=20card=20I=20got=20the=20following=20output:

loaded=20at:=20=20=20=20=2000400000=200052013C
board=20data=20at:=200051E124=200051E13C
relocated=20to:=20=20004040B8=20004040D0
zimage=20at:=20=20=20=20=2000404E45=200051DFC1
avail=20ram:=20=20=20=20=2000521000=2004000000

Linux/PPC=20load:=20console=3DttyS0,9600=20root=3D/dev/xsa3=20rw=20init=3D=
/sbin/init
Uncompressing=20Linux...done.
Now=20booting=20the=20kernel
[=20=20=20=200.000000]=20Linux=20version=202.6.20=20(butanowi@amandla)=20=
(gcc=20version=204.0.2)=20#3=20Mon=20Apr=209=2016:44:13=20CEST=202007
[=20=20=20=200.000000]=20Xilinx=20ML403=20Reference=20System=20(Virtex-4=20=
FX)
[=20=20=20=200.000000]=20Zone=20PFN=20ranges:
[=20=20=20=200.000000]=20=20=20DMA=20=20=20=20=20=20=20=20=20=20=20=20=20=
0=20->=20=20=20=2016384
[=20=20=20=200.000000]=20=20=20Normal=20=20=20=20=20=2016384=20->=20=20=20=
=2016384
[=20=20=20=200.000000]=20early=5Fnode=5Fmap[1]=20active=20PFN=20ranges
[=20=20=20=200.000000]=20=20=20=20=200:=20=20=20=20=20=20=20=200=20->=20=20=
=20=2016384
[=20=20=20=200.000000]=20Built=201=20zonelists.=20=20Total=20pages:=20162=
56
[=20=20=20=200.000000]=20Kernel=20command=20line:=20console=3DttyS0,9600=20=
root=3D/dev/xsa3=20rw=20init=3D/sbin/init
[=20=20=20=200.000000]=20Xilinx=20INTC=20#0=20at=200x41200000=20mapped=20=
to=200xFDFFE000
[=20=20=20=200.000000]=20PID=20hash=20table=20entries:=20256=20(order:=20=
8,=201024=20bytes)
[=20=20=20=200.000430]=20Console:=20colour=20dummy=20device=2080x25
[=20=20=20=200.001581]=20Dentry=20cache=20hash=20table=20entries:=208192=20=
(order:=203,=2032768=20bytes)
[=20=20=20=200.003395]=20Inode-cache=20hash=20table=20entries:=204096=20(=
order:=202,=2016384=20bytes)
[=20=20=20=200.036070]=20Memory:=2062476k=20available=20(1840k=20kernel=20=
code,=20488k=20data,=2096k=20init,=200k=20highmem)
[=20=20=20=200.221232]=20Mount-cache=20hash=20table=20entries:=20512
[=20=20=20=200.232180]=20NET:=20Registered=20protocol=20family=2016
[=20=20=20=200.269606]=20NET:=20Registered=20protocol=20family=202
[=20=20=20=200.361155]=20IP=20route=20cache=20hash=20table=20entries:=201=
024=20(order:=200,=204096=20bytes)
[=20=20=20=200.363365]=20TCP=20established=20hash=20table=20entries:=2020=
48=20(order:=201,=208192=20bytes)
[=20=20=20=200.363868]=20TCP=20bind=20hash=20table=20entries:=201024=20(o=
rder:=200,=204096=20bytes)
[=20=20=20=200.364143]=20TCP:=20Hash=20tables=20configured=20(established=
=202048=20bind=201024)
[=20=20=20=200.364229]=20TCP=20reno=20registered
[=20=20=20=200.401242]=20JFS:=20nTxBlock=20=3D=20488,=20nTxLock=20=3D=203=
908
[=20=20=20=200.408340]=20SGI=20XFS=20with=20no=20debug=20enabled
[=20=20=20=200.411933]=20io=20scheduler=20noop=20registered
[=20=20=20=200.412037]=20io=20scheduler=20deadline=20registered=20(defaul=
t)
[=20=20=20=200.517700]=20Serial:=208250/16550=20driver=20$Revision:=201.9=
0=20$=201=20ports,=20IRQ=20sharing=20disabled
[=20=20=20=200.524846]=20serial8250.0:=20ttyS0=20at=20MMIO=200x40401003=20=
(irq=20=3D=202)=20is=20a=2016550A
[=20=20=20=202.444102]=20RAMDISK=20driver=20initialized:=201=20RAM=20disk=
s=20of=204096K=20size=201024=20blocksize
[=20=20=20=202.536064]=20=20xsa:=20xsa1=20xsa2=20xsa3
[=20=20=20=202.602624]=20XTemac:=20using=20sgDMA=20mode.
[=20=20=20=202.646747]=20XTemac:=20not=20using=20TxDRE=20mode
[=20=20=20=202.694037]=20XTemac:=20using=20RxDRE=20mode
[=20=20=20=202.737007]=20XTemac:=20buffer=20descriptor=20size:=2032768=20=
(0x8000)
[=20=20=20=202.804113]=20XTemac:=20(buffer=5Fdescriptor=5Finit)=20phy:=20=
0x3c00000,=20virt:=200xff100000,=20size:=200x8000
[=20=20=20=203.004280]=20XTemac:=20Could=20not=20alloc=20TX=20buffer=2016=
8=20(9032=20bytes).=20Cleaning=20up.
[=20=20=20=203.093984]=20XTemac:=20Could=20not=20allocate=20TX=20buffers.=

[=20=20=20=203.156274]=20xilinx=5Ftemac:=20probe=20of=20xilinx=5Ftemac.0=20=
failed=20with=20error=20-5
[=20=20=20=203.236276]=20mice:=20PS/2=20mouse=20device=20common=20for=20a=
ll=20mice
[=20=20=20=203.299587]=20TCP=20cubic=20registered
[=20=20=20=203.338772]=20NET:=20Registered=20protocol=20family=201
[=20=20=20=203.391288]=20NET:=20Registered=20protocol=20family=2017
[=20=20=20=203.495078]=20EXT2-fs=20warning:=20mounting=20unchecked=20fs,=20=
running=20e2fsck=20is=20recommended
[=20=20=20=203.586449]=20VFS:=20Mounted=20root=20(ext2=20filesystem).
[=20=20=20=203.642764]=20Freeing=20unused=20kernel=20memory:=2096k=20init=

serial=20console=20detected.=20=20Disabling=20virtual=20terminals.
init=20started:=20=20BusyBox=20v0.60.2=20(2004.04.30-17:49+0000)=20multi-=
call=20binary

I=20have=20a=20problem=20with=20TxDRE:=20XTemac:=20not=20using=20TxDRE=20=
mode
[=20=20=20=203.004280]=20XTemac:=20Could=20not=20alloc=20TX=20buffer=2016=
8=20(9032=20bytes).=20Cleaning=20up.
[=20=20=20=203.093984]=20XTemac:=20Could=20not=20allocate=20TX=20buffers.=


Is=20it=20a=20problem=20related=20to=20my=20hardware=20design??=20
Looking=20for=20a=20help:-(=20or=20hint.=20I=20do=20not=20know=20what=20i=
s=20the=20problem=20related=20to.

Regards
Jaroslaw=20Butanowicz




>=20I=20have=20just=20learnt=20that=20MDIO=20lines=20are=20not=20connecte=
d=20in=20our=20design...=20that=20explains=20everything...=20thanks=20a=20=
lot.
>=20
>=20Leonid.
>=20
>=20-----Original=20Message-----
>=20From:=20Rick=20Moleres=20[mailto:Rick.Moleres@xilinx.com]=20
>=20Sent:=20Wednesday,=20April=2004,=202007=205:00=20PM
>=20To:=20Leonid;=20linuxppc-embedded@ozlabs.org
>=20Subject:=20RE:=20Linux=20w/ML403=20PLB=20TEMAC
>=20
>=20
>=20Leonid,
>=20
>=20If=20it's=20not=20the=20ML403=20board=20and=20the=20FX=20part=20is=20=
CES4=20or=20later=20(read=20this=20at=20the=20bottom=20of=20the=20FX=20ch=
ip),=20then=20you=20will=20need=20hard=5Ftemac=5Fv3=5F00=5Fb=20to=20get=20=
the=20MDIO=20access=20working=20properly.
>=20
>=20If=20this=20is=20pre-CES4=20silicon,=20then=20hard=5Ftemac=5Fv3=5F00=5F=
a=20is=20the=20right=20version=20and=20there=20may=20be=20an=20issue=20wi=
th=20the=20MDIO=20signal=20connectivity=20in=20your=20design=20(?=20just=20=
guessing).=20=20You=20can=20also=20try=20to=20hardcode=20the=20PHY=20addr=
ess=20(gmii=5Faddr)=20and=20see=20if=20the=20speed=20detection=20works=20=
at=20that=20point=20-=20but=20my=20guess=20is=20it=20won't.
>=20
>=20-Rick
>=20
>=20-----Original=20Message-----
>=20From:=20Leonid=20[mailto:Leonid@a-k-a.net]=20
>=20Sent:=20Wednesday,=20April=2004,=202007=205:50=20PM
>=20To:=20Rick=20Moleres;=20linuxppc-embedded@ozlabs.org
>=20Subject:=20RE:=20Linux=20w/ML403=20PLB=20TEMAC
>=20
>=20Hi,=20Rick:
>=20
>=20We=20have=20both=20in=20our=20design=20and=20both=20are=203.00a.=20I'=
m=20not=20sure=20why=20-=20I'll=20ask=20our=20HW=20folks.=20
>=20
>=20I=20have=20actually=20managed=20(just=2030=20minutes=20ago)=20to=20br=
ing=20up=20network=20interface=20but=20I=20have=20commented=20out=20all=20=
accesses=20to=20PHY=20in=20your=20adapter.c=20and=20I=20set=20speed=20to=20=
1000=20always=20(see=20my=20adapter.c=20attached).=20Without=20these=20ch=
anges=20packets=20are=20not=20transmitted=20out=20of=20board.
>=20
>=20This=20is=20probably=20some=20issue=20in=20my=20EDK=20project.
>=20
>=20I'm=20not=20using=20ML403=20actually=20but=20another=20proprietary=20=
board,=20based=20on=20Virtex
>=204=20(69FX)=20FPGA.
>=20
>=20Thanks,
>=20
>=20Leonid.
>=20
>=20-----Original=20Message-----
>=20From:=20Rick=20Moleres=20[mailto:Rick.Moleres@xilinx.com]=20
>=20Sent:=20Wednesday,=20April=2004,=202007=204:41=20PM
>=20To:=20Leonid;=20Glenn.G.Hart@us.westinghouse.com;=20linuxppc-embedded=
@ozlabs.org
>=20Subject:=20RE:=20Linux=20w/ML403=20PLB=20TEMAC
>=20
>=20Leonid,
>=20
>=20You=20mentioned=20that=20the=20TEMAC=20version=20if=20v3.00a.=20=20Is=
=20this=20the=20plb=5Ftemac=20version=20or=20the=20hard=5Ftemac=20version=
,=20or=20both?
>=20
>=20-Rick
>=20
>=20-----Original=20Message-----
>=20From:=20linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org=20[=
mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org]=20On=20=
Behalf=20Of=20Leonid
>=20Sent:=20Wednesday,=20April=2004,=202007=204:14=20PM
>=20To:=20Glenn.G.Hart@us.westinghouse.com;=20linuxppc-embedded@ozlabs.or=
g
>=20Subject:=20RE:=20Linux=20w/ML403=20PLB=20TEMAC
>=20
>=20I=20have=20investigated=20little=20bit=20more.=20Receive=20is=20worki=
ng=20actually,=20but=20transmit=20doesn't.=20What=20can=20it=20be?
>=20
>=20-----Original=20Message-----
>=20From:=20linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org=20[ma=
ilto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org]=20On=20Beha=
lf=20Of=20Leonid
>=20Sent:=20Wednesday,=20April=2004,=202007=2012:06=20PM
>=20To:=20Glenn.G.Hart@us.westinghouse.com;=20linuxppc-embedded@ozlabs.or=
g
>=20Subject:=20RE:=20Linux=20w/ML403=20PLB=20TEMAC
>=20
>=20I=20have=20precisely=20the=20same=20problem=20you=20have=20described:=

>=20
>=20[=20=20=20=200.430515]=20XTemac:=20using=20FIFO=20direct=20interrupt=20=
driven=20mode.
>=20[=20=20=20=200.437461]=20eth%d:=20XTemac:=20No=20PHY=20detected.=20=20=
Assuming=20a=20PHY=20at=20address=200
>=20[=20=20=20=200.445295]=20eth0:=20Xilinx=20TEMAC=20#0=20at=200x0200000=
0=20mapped=20to=200xC3000000,=20irq=3D0
>=20[=20=20=20=200.452256]=20eth0:=20XTemac=20id=201.0f,=20block=20id=205=
,=20type=208
>=20[=20=20=20=200.458665]=20tun:=20Universal=20TUN/TAP=20device=20driver=
,=201.6
>=20[=20=20=20=200.463712]=20tun:=20(C)=201999-2004=20Max=20Krasnyansky=20=
<maxk@qualcomm.com>
>=20[=20=20=20=200.471106]=20mice:=20PS/2=20mouse=20device=20common=20for=
=20all=20mice
>=20[=20=20=20=200.476339]=20TCP=20cubic=20registered
>=20[=20=20=20=200.479615]=20NET:=20Registered=20protocol=20family=201
>=20[=20=20=20=200.484032]=20NET:=20Registered=20protocol=20family=2017
>=20[=20=20=20=200.992599]=20eth0:=20XTemac:=20Options:=200xb8f2
>=20[=20=20=2012.955691]=20eth0:=20XTemac:=20Not=20able=20to=20set=20the=20=
speed=20to=201000=20(status:=200x0)
>=20[=20=20=2022.928615]=20eth0:=20XTemac:=20Not=20able=20to=20set=20the=20=
speed=20to=20100=20(status:=200x0)
>=20[=20=20=2032.901449]=20eth0:=20XTemac:=20Not=20able=20to=20set=20the=20=
speed=20to=2010=20(status:=200x0)
>=20[=20=20=2032.907976]=20eth0:=20XTemac:=20could=20not=20negotiate=20sp=
eed
>=20[=20=20=2033.921626]=20IP-Config:=20Complete:
>=20[=20=20=2033.924635]=20=20=20=20=20=20=20device=3Deth0,=20addr=3D192.=
168.0.223,=20mask=3D255.255.255.0,=20gw=3D192.168.0.1,
>=20[=20=20=2033.932418]=20=20=20=20=20=20host=3DLM200,=20domain=3D,=20ni=
s-domain=3D(none),
>=20[=20=20=2033.937715]=20=20=20=20=20=20bootserver=3D192.168.0.141,=20r=
ootserver=3D192.168.0.141,=20rootpath=3D
>=20[=20=20=2033.946230]=20Looking=20up=20port=20of=20RPC=20100003/2=20on=
=20192.168.0.141
>=20[=20=20=2034.916694]=20eth0:=20XTemac:=20PHY=20Link=20carrier=20lost.=

>=20
>=20My=20TEMAC=20core=20version=20is=203.00.a=20and=20low=20level=20code=20=
I'm=20using=20is=20working=20in=20u-boot=20wi
