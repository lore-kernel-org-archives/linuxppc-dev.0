Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s3.bay0.hotmail.com (bay0-omc1-s3.bay0.hotmail.com
	[65.54.246.75]) by ozlabs.org (Postfix) with ESMTP id 33A39DE107
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Apr 2008 19:09:47 +1000 (EST)
Message-ID: <BAY115-W23ED8F42C0F097D8A7864AB2E80@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_50875be1-fd1a-4164-9a00-b7e59b28ad79_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Rami WEHBI <rwehbi@wirecom-tech.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: XPS_LL_TEMAC works correctly?
Date: Mon, 14 Apr 2008 09:09:46 +0000
In-Reply-To: <D3C541E264C021479BFB60B3B790C0FB30A657@etoilenoire.STARWARS.local>
References: <D3C541E264C021479BFB60B3B790C0FB30A657@etoilenoire.STARWARS.local>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_50875be1-fd1a-4164-9a00-b7e59b28ad79_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Rami,

Thanks for reply,

But if u study the kernel log I posted carefully, you can simply see that K=
ernel has mounted the root file system,=20
Look at this line in my prev post : VFS: Mounted root (nfs filesystem). the=
n init has began and after that nothing more happens.=20

the NFS is working correctly and the folder can be mounted easily from othe=
r computers. I personally think that the problem can be with NFS or the roo=
t file system of ELDK.=20

I have done the same things with older versions of EDK using PLB_TEMAC and =
every thing has worked correctly.


Subject: RE: XPS_LL_TEMAC works correctly?
Date: Mon, 14 Apr 2008 10:31:31 +0200
From: rwehbi@wirecom-tech.com
To: mamsadegh@hotmail.com










Hi,
=20
I would suggest that you verify that your system file is already=20
mounted on the host PC (where your server NFS is installed), and that the=20
/etc/exports file (configuration file of the nfs server) permit to your boa=
rd to=20
mount the system file.
=20
example of an /etc/exports file:
=20
/opt/ml403/rootfs
192.168.206.223/24(rw,no_root_squash,sync,subtree_check)
=20
where the ip addresse is that of nfs client,=20
and the path indicates where I mounted the system file.
=20
Good=20
luck,
=20
Rami




De :=20
linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org=20
[mailto:linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org]=
 De=20
la part de Mohammad Sadegh Sadri
Envoy=E9 : lundi 14 avril 2008=20
10:16
=C0 : linuxppc-embedded@ozlabs.org
Objet :=20
XPS_LL_TEMAC works correctly?


Hi all,

Using:=20
EDK 9.2.02,=20
Xilinx Linux=20
2.6.24-rc8-xlnx
XPS_LL_TEMAC version 1.00.b

I bring up the Linux=20
kernel on ML403 -Rev04 board,
LL_TEMAC buffer size 128kbits, and set to use=20
SG DMA

I encounter the following messages when the kernel wants to mount=20
the root file system, as one can see the kernel has mounter the nfs root fi=
le=20
system and init is initiated, but after that a Link carrier lost happens an=
d it=20
stops working.=20

is this behavior natural? ( the PC has attansic gigabit=20
ethernet port with kernel 2.6.24.4 running, nfs works very well in other=20
tests)

thanks

.............
eth0: XLlTemac: speed set to=20
1000Mb/s
eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4
eth0:=20
XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254
IP-Config:=20
Complete:
      device=3Deth0, addr=3D10.10.10.11,=20
mask=3D255.255.255.0, gw=3D10.10.10.10,
    =20
host=3D10.10.10.11, domain=3D, nis-domain=3D(none),
    =20
bootserver=3D10.10.10.10, rootserver=3D10.10.10.10, rootpath=3D
Looking up port of=20
RPC 100003/2 on 10.10.10.10
Looking up port of RPC 100005/1 on=20
10.10.10.10
VFS: Mounted root (nfs filesystem).
Freeing unused kernel=20
memory: 88k init
eth0: XLlTemac: PHY Link carrier lost.
eth0: XLlTemac:=20
speed set to 1000Mb/s
eth0: XLlTemac: PHY Link carrier restored.
( KERNEL=20
STOPS WORKING HERE!!!!!!!!)





Sign in today. When you sign in to Windows Live Messenger you could win $10=
00 a=20
day until May 12th. Learn more at=20
SignInAndWIN.ca=20

_________________________________________________________________
Find hidden words, unscramble celebrity names, or try the ultimate crosswor=
d puzzle with Live Search Games. Play now!
http://g.msn.ca/ca55/212=

--_50875be1-fd1a-4164-9a00-b7e59b28ad79_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Rami,<br><br>Thanks for reply,<br><br>But if u study the kernel log I poste=
d carefully, you can simply see that Kernel has mounted the root file syste=
m, <br>Look at this line in my prev post : VFS: Mounted root (nfs filesyste=
m). then init has began and after that nothing more happens. <br><br>the NF=
S is working correctly and the folder can be mounted easily from other comp=
uters. I personally think that the problem can be with NFS or the root file=
 system of ELDK. <br><br>I have done the same things with older versions of=
 EDK using PLB_TEMAC and every thing has worked correctly.<br><br><br><bloc=
kquote><hr>Subject: RE: XPS_LL_TEMAC works correctly?<br>Date: Mon, 14 Apr =
2008 10:31:31 +0200<br>From: rwehbi@wirecom-tech.com<br>To: mamsadegh@hotma=
il.com<br><br>

<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dunicode">
<meta name=3D"Generator" content=3D"Microsoft SafeHTML">

<style>
.ExternalClass .EC_hmmessage P
{padding-right:0px;padding-left:0px;padding-bottom:0px;padding-top:0px;}
.ExternalClass BODY.EC_hmmessage
{font-size:10pt;font-family:Tahoma;}
</style>



<div dir=3D"ltr" align=3D"left"><span class=3D"EC_768232108-14042008"><font=
 color=3D"#0000ff" face=3D"Arial">Hi,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"EC_768232108-14042008"><font=
 color=3D"#0000ff" face=3D"Arial"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"EC_768232108-14042008"><font=
 color=3D"#0000ff" face=3D"Arial">I would suggest that you verify that your=
 system file is already=20
mounted on the host PC (where your server NFS is installed), and that the=20
/etc/exports file (configuration file of the nfs server) permit to your boa=
rd to=20
mount the system file.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"EC_768232108-14042008"><font=
 color=3D"#0000ff" face=3D"Arial"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"EC_768232108-14042008"><font=
 color=3D"#0000ff" face=3D"Arial">example of an /etc/exports file:</font></=
span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"EC_768232108-14042008"><font=
 color=3D"#0000ff" face=3D"Arial"></font></span>&nbsp;</div>
<p align=3D"left">/opt/ml403/rootfs</p>
192.168.206.223/24(rw,no_root_squash,sync,subtree_check)<BR>
<div>&nbsp;</div>
<div><span class=3D"EC_768232108-14042008">where the ip addresse is that of=
 nfs client,=20
and the path indicates where I mounted the system file.</span></div>
<div><span class=3D"EC_768232108-14042008"></span>&nbsp;</div>
<div><span class=3D"EC_768232108-14042008"><font color=3D"#0000ff" face=3D"=
Arial">Good=20
luck,</font></span></div>
<div><span class=3D"EC_768232108-14042008"><font color=3D"#0000ff" face=3D"=
Arial"></font></span>&nbsp;</div>
<div><span class=3D"EC_768232108-14042008"><font color=3D"#0000ff" face=3D"=
Arial">Rami</font></span></div>
<div><br></div>
<div class=3D"EC_OutlookMessageHeader" dir=3D"ltr" align=3D"left" lang=3D"f=
r">
<hr>
<b>De&nbsp;:</b>=20
linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org=20
[mailto:linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org]=
 <b>De=20
la part de</b> Mohammad Sadegh Sadri<br><b>Envoy=E9&nbsp;:</b> lundi 14 avr=
il 2008=20
10:16<br><b>=C0&nbsp;:</b> linuxppc-embedded@ozlabs.org<br><b>Objet&nbsp;:<=
/b>=20
XPS_LL_TEMAC works correctly?<br><br></div>
<div></div>Hi all,<br><br>Using: <br>EDK 9.2.02, <br>Xilinx Linux=20
2.6.24-rc8-xlnx<br>XPS_LL_TEMAC version 1.00.b<br><br>I bring up the Linux=
=20
kernel on ML403 -Rev04 board,<br>LL_TEMAC buffer size 128kbits, and set to =
use=20
SG DMA<br><br>I encounter the following messages when the kernel wants to m=
ount=20
the root file system, as one can see the kernel has mounter the nfs root fi=
le=20
system and init is initiated, but after that a Link carrier lost happens an=
d it=20
stops working. <br><br>is this behavior natural? ( the PC has attansic giga=
bit=20
ethernet port with kernel 2.6.24.4 running, nfs works very well in other=20
tests)<br><br>thanks<br><br>.............<br>eth0: XLlTemac: speed set to=20
1000Mb/s<br>eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4<=
br>eth0:=20
XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254<br>IP-Config:=
=20
Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, addr=3D10.10.10.=
11,=20
mask=3D255.255.255.0, gw=3D10.10.10.10,<br>&nbsp;&nbsp;&nbsp;&nbsp;=20
host=3D10.10.10.11, domain=3D, nis-domain=3D(none),<br>&nbsp;&nbsp;&nbsp;&n=
bsp;=20
bootserver=3D10.10.10.10, rootserver=3D10.10.10.10, rootpath=3D<br>Looking =
up port of=20
RPC 100003/2 on 10.10.10.10<br>Looking up port of RPC 100005/1 on=20
10.10.10.10<br>VFS: Mounted root (nfs filesystem).<br>Freeing unused kernel=
=20
memory: 88k init<br>eth0: XLlTemac: PHY Link carrier lost.<br>eth0: XLlTema=
c:=20
speed set to 1000Mb/s<br>eth0: XLlTemac: PHY Link carrier restored.<br>( KE=
RNEL=20
STOPS WORKING HERE!!!!!!!!)<br><br><br><br>
<hr>
Sign in today. When you sign in to Windows Live Messenger you could win $10=
00 a=20
day until May 12th. <a href=3D"http://g.msn.ca/ca55/209" target=3D"_blank">=
Learn more at=20
SignInAndWIN.ca</a>=20
</blockquote><br /><hr />Sign in now! Windows Live Messenger is giving you =
a chance to win $1000 a day until May 12th <a href=3D'http://g.msn.ca/ca55/=
214' target=3D'_new'>Check out SignInAndWIN.ca today!</a></body>
</html>=

--_50875be1-fd1a-4164-9a00-b7e59b28ad79_--
