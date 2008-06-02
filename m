Return-Path: <huubeikens@hotmail.com>
Received: from bay0-omc1-s36.bay0.hotmail.com (bay0-omc1-s36.bay0.hotmail.com
	[65.54.246.108]) by ozlabs.org (Postfix) with ESMTP id 5BE72DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Jun 2008 20:14:05 +1000 (EST)
Message-ID: <BAY122-W2781EE45C1BA6DF67E10A2DABB0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_000808b6-943f-4476-825a-086700f3134e_"
From: Huub Eikens <huubeikens@hotmail.com>
To: Li Yang <leoli@freescale.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: USB Host-to-Serial or USB Host-to-Ethernet
Date: Mon, 2 Jun 2008 10:14:04 +0000
In-Reply-To: <989B956029373F45A0B8AF02970818900250DC6C@zch01exm26.fsl.freescale.net>
References: <BAY122-W428F4FD4AED8DAED5968A1DABF0@phx.gbl><200805291414.26798.laurentp@cse-semaphore.com>
	<BAY122-W337F19C2D451B0405A1391DABB0@phx.gbl>
	<989B956029373F45A0B8AF02970818900250DC6C@zch01exm26.fsl.freescale.net>
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

--_000808b6-943f-4476-825a-086700f3134e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Can you use a PCI USB card? I don't quite understand how USB-to-serial or=
 USB-to-ethernet can help you mount a USB memory stick.=20
> Unless you want USB memory stick to be mounted on another system and expo=
rted with NFS.
Also due to the hardare layout, I cannot use any PCI interface. I only have=
 serial(UART) or ethernet. Huub
> Subject: RE: USB Host-to-Serial or USB Host-to-Ethernet> Date: Mon, 2 Jun=
 2008 17:42:01 +0800> From: LeoLi@freescale.com> To: huubeikens@hotmail.com=
; linuxppc-embedded@ozlabs.org> > > -----Original Message-----> > From: > >=
 linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org > > [mailto:lin=
uxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.o> > rg] On Behalf Of H=
uub Eikens> > Sent: Monday, June 02, 2008 5:22 PM> > To: linuxppc-embedded@=
ozlabs.org> > Subject: USB Host-to-Serial or USB Host-to-Ethernet> > > > Hi=
,> > > > I have platform based on the Freescale MPC8270 processor that > > =
runs on linux 2.4.25. On it I want to mount a memory stick. > > Due to hard=
ware (layout) restrictions , I cannot use an > > external USB Host Controll=
er. Also, I cannot use the on-chip > > USB Host Controller since there is n=
o driver available that > > is reliable and has good performance.> > > > Th=
erefor, I am exploring the possibility of doing a > > USB-to-Serial or USB-=
to-ethernet. Does anyone know which chip > > to use for which a driver exis=
ts for linux 2.4.25? Note that > > such a chip must act as a USB Host (!). =
> > Can you use a PCI USB card? I don't quite understand how USB-to-serial =
or USB-to-ethernet can help you mount a USB memory stick. Unless you want U=
SB memory stick to be mounted on another system and exported with NFS.> > -=
 Leo> _______________________________________________> Linuxppc-embedded ma=
iling list> Linuxppc-embedded@ozlabs.org> https://ozlabs.org/mailman/listin=
fo/linuxppc-embedded
_________________________________________________________________
Check je Hotmail nu ook op je mobiel!
http://windowslivemobile.msn.com/BrowserServiceHotmail.aspx?lang=3Dnl-nl=

--_000808b6-943f-4476-825a-086700f3134e_
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
<body class=3D'hmmessage'>&gt; Can you use a PCI USB card? I don't quite un=
derstand how USB-to-serial or USB-to-ethernet can help you mount a USB memo=
ry stick. <BR>
&gt; Unless you want USB memory stick to be mounted on another system and e=
xported with NFS.<BR>
<BR>Also due to the hardare layout, I cannot use any PCI interface. I only =
have serial(UART) or ethernet.<BR>&nbsp;<BR>Huub<BR><BR>
&gt; Subject: RE: USB Host-to-Serial or USB Host-to-Ethernet<BR>&gt; Date: =
Mon, 2 Jun 2008 17:42:01 +0800<BR>&gt; From: LeoLi@freescale.com<BR>&gt; To=
: huubeikens@hotmail.com; linuxppc-embedded@ozlabs.org<BR>&gt; <BR>&gt; &gt=
; -----Original Message-----<BR>&gt; &gt; From: <BR>&gt; &gt; linuxppc-embe=
dded-bounces+leoli=3Dfreescale.com@ozlabs.org <BR>&gt; &gt; [mailto:linuxpp=
c-embedded-bounces+leoli=3Dfreescale.com@ozlabs.o<BR>&gt; &gt; rg] On Behal=
f Of Huub Eikens<BR>&gt; &gt; Sent: Monday, June 02, 2008 5:22 PM<BR>&gt; &=
gt; To: linuxppc-embedded@ozlabs.org<BR>&gt; &gt; Subject: USB Host-to-Seri=
al or USB Host-to-Ethernet<BR>&gt; &gt; <BR>&gt; &gt; Hi,<BR>&gt; &gt; <BR>=
&gt; &gt; I have platform based on the Freescale MPC8270 processor that <BR=
>&gt; &gt; runs on linux 2.4.25. On it I want to mount a memory stick. <BR>=
&gt; &gt; Due to hardware (layout) restrictions , I cannot use an <BR>&gt; =
&gt; external USB Host Controller. Also, I cannot use the on-chip <BR>&gt; =
&gt; USB Host Controller since there is no driver available that <BR>&gt; &=
gt; is reliable and has good performance.<BR>&gt; &gt; <BR>&gt; &gt; Theref=
or, I am exploring the possibility of doing a <BR>&gt; &gt; USB-to-Serial o=
r USB-to-ethernet. Does anyone know which chip <BR>&gt; &gt; to use for whi=
ch a driver exists for linux 2.4.25? Note that <BR>&gt; &gt; such a chip mu=
st act as a USB Host (!). <BR>&gt; <BR>&gt; Can you use a PCI USB card? I d=
on't quite understand how USB-to-serial or USB-to-ethernet can help you mou=
nt a USB memory stick. Unless you want USB memory stick to be mounted on an=
other system and exported with NFS.<BR>&gt; <BR>&gt; - Leo<BR>&gt; ________=
_______________________________________<BR>&gt; Linuxppc-embedded mailing l=
ist<BR>&gt; Linuxppc-embedded@ozlabs.org<BR>&gt; https://ozlabs.org/mailman=
/listinfo/linuxppc-embedded<BR><BR><br /><hr />Het beste van Windows, nu oo=
k online. <a href=3D'http://get.live.com/nl-nl/wl/all' target=3D'_new'>Deel=
 jouw wereld met Windows Live. Download nu.</a></body>
</html>=

--_000808b6-943f-4476-825a-086700f3134e_--
