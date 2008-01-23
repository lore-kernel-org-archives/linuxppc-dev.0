Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s23.bay0.hotmail.com (bay0-omc1-s23.bay0.hotmail.com
	[65.54.246.95]) by ozlabs.org (Postfix) with ESMTP id 34BF8DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 18:35:37 +1100 (EST)
Message-ID: <BAY115-W415137ADEA0BE4A33D2BAEB23F0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_e69d3237-842d-4cc0-902b-8c61b56620fe_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>, David Baird
	<dhbaird@gmail.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Wed, 23 Jan 2008 07:35:36 +0000
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333F0A5952@XMBIL132.northgrum.com>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl><440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com>
	<BAY115-W344A18C61627B3075C6281B23D0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A5952@XMBIL132.northgrum.com>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_e69d3237-842d-4cc0-902b-8c61b56620fe_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi

Well, As you know, we now need a PLB version, XPS_LL_TEMAC is connected to =
PLB not MPMC2...yes I remember those days of Xilinx GSRD and MPMC2 however =
it seems that the current architecture has slight changes.=20

about the git repository of Xilinx, Although I do not believe on it, I'll g=
ive it a try...thanks for info.

well, what about Grant Likely... and his git tree?

Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Mon, 21 Jan 2008 11:44:14 -0600
From: mike.koss@ngc.com
To: mamsadegh@hotmail.com; dhbaird@gmail.com; linuxppc-embedded@ozlabs.org










In case anyone is interested, I'm currently working on=20
an almost-kernel-ready version that will be self-contained based on the LL-=
DMA=20
version (the native MPMC port, not the PLB). It's based upon the old adapte=
r=20
from MontaVista, that I originally ported to 2.6 and the MPMC2. Unfortunate=
ly,=20
it won't be ready for another few weeks since I'm working on hardware image=
s=20
currently.
=20
-- Mike



From: Mohammad Sadegh Sadri=20
[mailto:mamsadegh@hotmail.com]=20
Sent: Monday, January 21, 2008 3:54=20
AM
To: David Baird; linuxppc-embedded@ozlabs.org
Subject:=20
RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC


thanks for you reply david,

As far as I know the Linux driver=20
for Xilinx PLB TEMAC was two parts : 1- adapter.c and 2- the rest of the dr=
iver=20
files

Only adapter.c was really a linux related file and the rest of the=20
files were Xilinx generic driver code for PLB TEMAC.

correct?

then=20
now, I know EDK 9.2 generates the needed Linux support package and needed=20
related files, so if this is the case can we use these files as the needed=
=20
driver in our linux kernel?

by the way, i did never hear about this git=20
repository before...can you describe us, where is it and how we can access =
it=20
and which projects are now hosted by it?


thanks


> Date:=20
Mon, 21 Jan 2008 00:54:30 -0700
> From: dhbaird@gmail.com
> To:=20
mamsadegh@hotmail.com
> Subject: Re: Xilinx XPS_LL_TEMAC vs=20
PLB_TEMAC
>=20
> On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadri=20
<mamsadegh@hotmail.com> wrote:
> > As you know Xilinx PLB TEMAC=20
is a module which connects Hard TEMAC in
> > Virtex-4 FX devices to PLB=20
bus,
> > now, in the new release of EDK , EDK 9.2 Xilinx has added a=20
new interface
> > core , which is called XPS_LL_TEMAC and has a=20
different structure than
> > normal PLB TEMAC. spacially it has some=20
additional data transfer buses.
> >
> > Now the question=20
is,... is there any linux driver available for this new
> >=20
core?
>=20
> Yes there is, but I had to use the git sources=20
at:
>=20
> git.xilinx.com





_________________________________________________________________


--_e69d3237-842d-4cc0-902b-8c61b56620fe_
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
Hi<br><br>Well, As you know, we now need a PLB version, XPS_LL_TEMAC is con=
nected to PLB not MPMC2...yes I remember those days of Xilinx GSRD and MPMC=
2 however it seems that the current architecture has slight changes. <br><b=
r>about the git repository of Xilinx, Although I do not believe on it, I'll=
 give it a try...thanks for info.<br><br>well, what about Grant Likely... a=
nd his git tree?<br><br><blockquote><hr>Subject: RE: Xilinx XPS_LL_TEMAC vs=
 PLB_TEMAC<br>Date: Mon, 21 Jan 2008 11:44:14 -0600<br>From: mike.koss@ngc.=
com<br>To: mamsadegh@hotmail.com; dhbaird@gmail.com; linuxppc-embedded@ozla=
bs.org<br><br>

<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dunicode">
<meta name=3D"Generator" content=3D"Microsoft SafeHTML">

<style>
.ExternalClass .EC_hmmessage P
{padding-right:0px;padding-left:0px;padding-bottom:0px;padding-top:0px;}
.ExternalClass EC_BODY.hmmessage
{font-size:10pt;font-family:Tahoma;}
</style>



<div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" face=3D"Arial"><spa=
n class=3D"EC_188023817-21012008">In case anyone is interested, I'm current=
ly working on=20
an almost-kernel-ready version that will be self-contained based on the LL-=
DMA=20
version (the native MPMC port, not the PLB). It's based upon the old adapte=
r=20
from MontaVista, that I originally ported to 2.6 and the MPMC2. Unfortunate=
ly,=20
it won't be ready for another few weeks since I'm working on hardware image=
s=20
currently.</span></font></div>
<div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" face=3D"Arial"><spa=
n class=3D"EC_188023817-21012008"></span></font>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" face=3D"Arial"><spa=
n class=3D"EC_188023817-21012008">-- Mike</span></font></div><font color=3D=
"#0000ff" face=3D"Arial"></font><br>
<div class=3D"EC_OutlookMessageHeader" dir=3D"ltr" align=3D"left" lang=3D"e=
n-us">
<hr>
<font face=3D"Tahoma"><b>From:</b> Mohammad Sadegh Sadri=20
[mailto:mamsadegh@hotmail.com] <br><b>Sent:</b> Monday, January 21, 2008 3:=
54=20
AM<br><b>To:</b> David Baird; linuxppc-embedded@ozlabs.org<br><b>Subject:</=
b>=20
RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC<br></font><br></div>
<div></div>thanks for you reply david,<br><br>As far as I know the Linux dr=
iver=20
for Xilinx PLB TEMAC was two parts : 1- adapter.c and 2- the rest of the dr=
iver=20
files<br><br>Only adapter.c was really a linux related file and the rest of=
 the=20
files were Xilinx generic driver code for PLB TEMAC.<br><br>correct?<br><br=
>then=20
now, I know EDK 9.2 generates the needed Linux support package and needed=20
related files, so if this is the case can we use these files as the needed=
=20
driver in our linux kernel?<br><br>by the way, i did never hear about this =
git=20
repository before...can you describe us, where is it and how we can access =
it=20
and which projects are now hosted by it?<br><br><br>thanks<br><br><br>&gt; =
Date:=20
Mon, 21 Jan 2008 00:54:30 -0700<br>&gt; From: dhbaird@gmail.com<br>&gt; To:=
=20
mamsadegh@hotmail.com<br>&gt; Subject: Re: Xilinx XPS_LL_TEMAC vs=20
PLB_TEMAC<br>&gt; <br>&gt; On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadri=
=20
&lt;mamsadegh@hotmail.com&gt; wrote:<br>&gt; &gt; As you know Xilinx PLB TE=
MAC=20
is a module which connects Hard TEMAC in<br>&gt; &gt; Virtex-4 FX devices t=
o PLB=20
bus,<br>&gt; &gt; now, in the new release of EDK , EDK 9.2 Xilinx has added=
 a=20
new interface<br>&gt; &gt; core , which is called XPS_LL_TEMAC and has a=20
different structure than<br>&gt; &gt; normal PLB TEMAC. spacially it has so=
me=20
additional data transfer buses.<br>&gt; &gt;<br>&gt; &gt; Now the question=
=20
is,... is there any linux driver available for this new<br>&gt; &gt;=20
core?<br>&gt; <br>&gt; Yes there is, but I had to use the git sources=20
at:<br>&gt; <br>&gt; git.xilinx.com<br><br>
<hr>
<a href=3D"http://" target=3D"_blank"></a>
</blockquote><br /><hr /> <a href=3D'' target=3D'_new'></a></body>
</html>=

--_e69d3237-842d-4cc0-902b-8c61b56620fe_--
