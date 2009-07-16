Return-Path: <sumeshkkn@hotmail.com>
Received: from blu0-omc3-s21.blu0.hotmail.com (blu0-omc3-s21.blu0.hotmail.com
	[65.55.116.96])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 233F2B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 22:15:28 +1000 (EST)
Message-ID: <BLU124-W13E23FC260877718FE8353B4210@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_dbcbff76-b1ec-4de7-afd9-b201946874f7_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Linux with RAM mapped other than zero.
Date: Thu, 16 Jul 2009 12:08:46 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_dbcbff76-b1ec-4de7-afd9-b201946874f7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all=2C I've a system design  (32 bit) with SDRAM mapped at 0xf8000000 ra=
ther than at 0. what are the changes i should make to successfully boot a k=
ernel..? my design with SDRAM at 0 (64MB) is working fine with xilinx git l=
ine kernel(2.6.27).  i was using 'make simpleImage.xilinx (where xilinx.dts=
 is my device tree file) i tried to change the link_address in arch/powerpc=
/boot/wrapper from 0x400000 to 0xf4000000. when i analysed the dump with st=
ep mode in xmd=2C it fails in platform_init()function in arch/powerpc/boot/=
simpleboot.c may be at /* Only interested in memory based at 0 */
 for (i =3D 0=3B i < *na=3B i++)
  if (*reg++ !=3D 0)
   fatal("Memory range is not based at address 0\n")=3B  can anyone tell wh=
at are the changes i shoud do if my memory ranges from 0xf8000000 to 0xfbff=
ffff..? (64MB)
is it possible to change the  physical address of kernel from 0 to any othe=
r location..? is the option provided in menuconfig..? or in any linker scri=
pt..? =20
  Thanks in advance=2CSumesh.
_________________________________________________________________
Looking for a new car this winter? Let us help with car news=2C reviews and=
 more
http://a.ninemsn.com.au/b.aspx?URL=3Dhttp%3A%2F%2Fsecure%2Dau%2Eimrworldwid=
e%2Ecom%2Fcgi%2Dbin%2Fa%2Fci%5F450304%2Fet%5F2%2Fcg%5F801459%2Fpi%5F1004813=
%2Fai%5F859641&_t=3D762955845&_r=3Dtig_OCT07&_m=3DEXT=

--_dbcbff76-b1ec-4de7-afd9-b201946874f7_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
<span class=3D"Apple-style-span" style=3D"color: rgb(0=2C 0=2C 0)=3B font-f=
amily: Arial=3B -webkit-border-horizontal-spacing: 2px=3B -webkit-border-ve=
rtical-spacing: 2px=3B "><p style=3D"margin-top: 0px=3B margin-right: 0px=
=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding-r=
ight: 0px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">Hi all=2C</p><p =
style=3D"margin-top: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B marg=
in-left: 0px=3B padding-top: 0px=3B padding-right: 0px=3B padding-bottom: 0=
px=3B padding-left: 0px=3B ">&nbsp=3B</p><p style=3D"margin-top: 0px=3B mar=
gin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-top: 0p=
x=3B padding-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">I'=
ve a system design&nbsp=3B&nbsp=3B(32 bit)&nbsp=3Bwith SDRAM mapped at 0xf8=
000000 rather than at 0. what are the changes i should make to successfully=
 boot a kernel..?</p><p style=3D"margin-top: 0px=3B margin-right: 0px=3B ma=
rgin-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding-right: =
0px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">&nbsp=3B</p><p style=
=3D"margin-top: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-le=
ft: 0px=3B padding-top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B=
 padding-left: 0px=3B "><em>my design with SDRAM at 0 (64MB) is working fin=
e with xilinx git line kernel(2.6.27).&nbsp=3B i was using 'make simpleImag=
e.xilinx (where xilinx.dts is my device tree file)</em></p><p style=3D"marg=
in-top: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=
=3B padding-top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B paddin=
g-left: 0px=3B ">&nbsp=3B</p><p style=3D"margin-top: 0px=3B margin-right: 0=
px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding=
-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">i tried to cha=
nge the link_address in arch/powerpc/boot/wrapper from 0x400000 to 0xf40000=
00. when i analysed the dump with step mode&nbsp=3Bin xmd=2C it fails in&nb=
sp=3B<strong>platform_init()</strong>function in&nbsp=3B<strong>arch/powerp=
c/boot/simpleboot.c</strong></p><p style=3D"margin-top: 0px=3B margin-right=
: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padd=
ing-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">&nbsp=3B</p=
><p style=3D"margin-top: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B =
margin-left: 0px=3B padding-top: 0px=3B padding-right: 0px=3B padding-botto=
m: 0px=3B padding-left: 0px=3B ">may be at</p><p style=3D"margin-top: 0px=
=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-=
top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=
=3B ">&nbsp=3B</p><p style=3D"margin-top: 0px=3B margin-right: 0px=3B margi=
n-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding-right: 0px=
=3B padding-bottom: 0px=3B padding-left: 0px=3B "><em>/* Only interested in=
 memory based at 0 */<br>&nbsp=3Bfor (i =3D 0=3B i &lt=3B *na=3B i++)<br>&n=
bsp=3B&nbsp=3Bif (*reg++ !=3D 0)<br>&nbsp=3B&nbsp=3B&nbsp=3Bfatal("Memory r=
ange is not based at address 0\n")=3B</em></p><p style=3D"margin-top: 0px=
=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-=
top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=
=3B ">&nbsp=3B</p><p style=3D"margin-top: 0px=3B margin-right: 0px=3B margi=
n-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding-right: 0px=
=3B padding-bottom: 0px=3B padding-left: 0px=3B ">&nbsp=3B</p><p style=3D"m=
argin-top: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0=
px=3B padding-top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B padd=
ing-left: 0px=3B ">can anyone tell what are the changes i shoud do if my me=
mory ranges from 0xf8000000 to 0xfbffffff..? (64MB)</p><p style=3D"margin-t=
op: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B p=
adding-top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B padding-lef=
t: 0px=3B "><br></p><p style=3D"margin-top: 0px=3B margin-right: 0px=3B mar=
gin-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding-right: 0=
px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">is it possible to chang=
e the &nbsp=3Bphysical address of kernel from 0 to any other location..? is=
 the option provided in menuconfig..? or in any linker script..?</p><p styl=
e=3D"margin-top: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-l=
eft: 0px=3B padding-top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=
=3B padding-left: 0px=3B ">&nbsp=3B</p><p style=3D"margin-top: 0px=3B margi=
n-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=
=3B padding-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">&nb=
sp=3B</p><p style=3D"margin-top: 0px=3B margin-right: 0px=3B margin-bottom:=
 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding-right: 0px=3B paddi=
ng-bottom: 0px=3B padding-left: 0px=3B "><br></p><p style=3D"margin-top: 0p=
x=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding=
-top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=
=3B ">&nbsp=3B</p><p style=3D"margin-top: 0px=3B margin-right: 0px=3B margi=
n-bottom: 0px=3B margin-left: 0px=3B padding-top: 0px=3B padding-right: 0px=
=3B padding-bottom: 0px=3B padding-left: 0px=3B ">&nbsp=3B</p><p style=3D"m=
argin-top: 0px=3B margin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0=
px=3B padding-top: 0px=3B padding-right: 0px=3B padding-bottom: 0px=3B padd=
ing-left: 0px=3B ">Thanks in advance=2C</p><p style=3D"margin-top: 0px=3B m=
argin-right: 0px=3B margin-bottom: 0px=3B margin-left: 0px=3B padding-top: =
0px=3B padding-right: 0px=3B padding-bottom: 0px=3B padding-left: 0px=3B ">=
Sumesh.</p></span><br /><hr />Let us help with car news=2C reviews and more=
 <a href=3D'http://a.ninemsn.com.au/b.aspx?URL=3Dhttp%3A%2F%2Fsecure%2Dau%2=
Eimrworldwide%2Ecom%2Fcgi%2Dbin%2Fa%2Fci%5F450304%2Fet%5F2%2Fcg%5F801459%2F=
pi%5F1004813%2Fai%5F859641&_t=3D762955845&_r=3Dtig_OCT07&_m=3DEXT' target=
=3D'_new'>Looking for a new car this winter?</a></body>
</html>=

--_dbcbff76-b1ec-4de7-afd9-b201946874f7_--
