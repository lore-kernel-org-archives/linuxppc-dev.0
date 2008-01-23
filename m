Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s12.bay0.hotmail.com (bay0-omc1-s12.bay0.hotmail.com
	[65.54.246.84]) by ozlabs.org (Postfix) with ESMTP id 233CEDDE46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 02:12:39 +1100 (EST)
Message-ID: <BAY115-W393608FBCB3E1070428538B23F0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_51985bad-c31e-46bd-a04f-43e09a27939e_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>, David Baird
	<dhbaird@gmail.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Wed, 23 Jan 2008 15:12:38 +0000
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333F0A5959@XMBIL132.northgrum.com>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl><440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com>
	<BAY115-W344A18C61627B3075C6281B23D0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A5952@XMBIL132.northgrum.com>
	<BAY115-W415137ADEA0BE4A33D2BAEB23F0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A5959@XMBIL132.northgrum.com>
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

--_51985bad-c31e-46bd-a04f-43e09a27939e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


So, in this case, our base system, created with EDK 9.2 will not be the sam=
e as previous systems, as shown in=20
http://www.xilinx.com/esp/wired/optical/xlnx_net/mpmc.htm
PLB and OPB usage is limited to a small area of design...

Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Wed, 23 Jan 2008 07:43:14 -0600
From: mike.koss@ngc.com
To: mamsadegh@hotmail.com; dhbaird@gmail.com; linuxppc-embedded@ozlabs.org










Actually, with the MPMC3 the XPS_LL_TEMAC still can=20
directly connect to the MPMC. You set one of the ports' type to SDMA and it=
=20
instantiates what is similar to the old CDMAC.=20



From: Mohammad Sadegh Sadri=20
[mailto:mamsadegh@hotmail.com]=20
Sent: Wednesday, January 23, 2008 2:36=20
AM
To: Koss, Mike (Mission Systems); David Baird;=20
linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx XPS_LL_TEMAC vs=20
PLB_TEMAC


Hi

Well, As you know, we now need a PLB version, XPS_LL_TEMAC=20
is connected to PLB not MPMC2...yes I remember those days of Xilinx GSRD an=
d=20
MPMC2 however it seems that the current architecture has slight changes.=20


about the git repository of Xilinx, Although I do not believe on it,=20
I'll give it a try...thanks for info.

well, what about Grant Likely...=20
and his git tree?



 =20
  Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Mon, 21 Jan 2008=20
  11:44:14 -0600
From: mike.koss@ngc.com
To: mamsadegh@hotmail.com;=20
  dhbaird@gmail.com; linuxppc-embedded@ozlabs.org


 =20
 =20

  In case anyone is interested, I'm currently=20
  working on an almost-kernel-ready version that will be self-contained bas=
ed on=20
  the LL-DMA version (the native MPMC port, not the PLB). It's based upon t=
he=20
  old adapter from MontaVista, that I originally ported to 2.6 and the MPMC=
2.=20
  Unfortunately, it won't be ready for another few weeks since I'm working =
on=20
  hardware images currently.
  =20
  -- Mike

 =20
 =20
  From: Mohammad Sadegh Sadri=20
  [mailto:mamsadegh@hotmail.com]=20
Sent: Monday, January 21, 2008 3:54=20
  AM
To: David Baird; linuxppc-embedded@ozlabs.org
Subject:=20
  RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC


  thanks for you reply david,

As far as I know the Linux=20
  driver for Xilinx PLB TEMAC was two parts : 1- adapter.c and 2- the rest =
of=20
  the driver files

Only adapter.c was really a linux related file and the=20
  rest of the files were Xilinx generic driver code for PLB=20
  TEMAC.

correct?

then now, I know EDK 9.2 generates the needed=20
  Linux support package and needed related files, so if this is the case ca=
n we=20
  use these files as the needed driver in our linux kernel?

by the way, i=20
  did never hear about this git repository before...can you describe us, wh=
ere=20
  is it and how we can access it and which projects are now hosted by=20
  it?


thanks


> Date: Mon, 21 Jan 2008 00:54:30=20
  -0700
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
> > Virtex-4 FX devices to=20
  PLB bus,
> > now, in the new release of EDK , EDK 9.2 Xilinx has=20
  added a new interface
> > core , which is called XPS_LL_TEMAC and has=20
  a different structure than
> > normal PLB TEMAC. spacially it has=20
  some additional data transfer buses.
> >
> > Now the=20
  question is,... is there any linux driver available for this new
> >=20
  core?
>=20
> Yes there is, but I had to use the git sources=20
  at:
>=20
> git.xilinx.com


 =20
 =20




_________________________________________________________________


--_51985bad-c31e-46bd-a04f-43e09a27939e_
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
So, in this case, our base system, created with EDK 9.2 will not be the sam=
e as previous systems, as shown in <br>http://www.xilinx.com/esp/wired/opti=
cal/xlnx_net/mpmc.htm<br>PLB and OPB usage is limited to a small area of de=
sign...<br><br><blockquote><hr>Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMA=
C<br>Date: Wed, 23 Jan 2008 07:43:14 -0600<br>From: mike.koss@ngc.com<br>To=
: mamsadegh@hotmail.com; dhbaird@gmail.com; linuxppc-embedded@ozlabs.org<br=
><br>

<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dunicode">
<meta name=3D"Generator" content=3D"Microsoft SafeHTML">

<style>
.ExternalClass .EC_hmmessage P
{padding-right:0px;padding-left:0px;padding-bottom:0px;padding-top:0px;}
.ExternalClass EC_BODY.hmmessage
{font-size:10pt;font-family:Tahoma;}
</style>



<div dir=3D"ltr" align=3D"left"><span class=3D"EC_578424013-23012008"><font=
 color=3D"#0000ff" face=3D"Arial">Actually, with the MPMC3&nbsp;the XPS_LL_=
TEMAC&nbsp;still can=20
directly connect to the MPMC. You set one of the ports' type&nbsp;to SDMA a=
nd it=20
instantiates what is similar to the old CDMAC. </font></span></div><br>
<div class=3D"EC_OutlookMessageHeader" dir=3D"ltr" align=3D"left" lang=3D"e=
n-us">
<hr>
<font face=3D"Tahoma"><b>From:</b> Mohammad Sadegh Sadri=20
[mailto:mamsadegh@hotmail.com] <br><b>Sent:</b> Wednesday, January 23, 2008=
 2:36=20
AM<br><b>To:</b> Koss, Mike (Mission Systems); David Baird;=20
linuxppc-embedded@ozlabs.org<br><b>Subject:</b> RE: Xilinx XPS_LL_TEMAC vs=
=20
PLB_TEMAC<br></font><br></div>
<div></div>Hi<br><br>Well, As you know, we now need a PLB version, XPS_LL_T=
EMAC=20
is connected to PLB not MPMC2...yes I remember those days of Xilinx GSRD an=
d=20
MPMC2 however it seems that the current architecture has slight changes.=20
<br><br>about the git repository of Xilinx, Although I do not believe on it=
,=20
I'll give it a try...thanks for info.<br><br>well, what about Grant Likely.=
..=20
and his git tree?<br><br>
<blockquote>
  <hr>
  Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC<br>Date: Mon, 21 Jan 2008=20
  11:44:14 -0600<br>From: mike.koss@ngc.com<br>To: mamsadegh@hotmail.com;=20
  dhbaird@gmail.com; linuxppc-embedded@ozlabs.org<br><br>
 =20
  <style>
.ExternalClass .EC_hmmessage P
{padding-right:0px;padding-left:0px;padding-bottom:0px;padding-top:0px;}
.ExternalClass EC_BODY.hmmessage
{font-size:10pt;font-family:Tahoma;}
</style>

  <div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" face=3D"Arial"><s=
pan class=3D"EC_EC_188023817-21012008">In case anyone is interested, I'm cu=
rrently=20
  working on an almost-kernel-ready version that will be self-contained bas=
ed on=20
  the LL-DMA version (the native MPMC port, not the PLB). It's based upon t=
he=20
  old adapter from MontaVista, that I originally ported to 2.6 and the MPMC=
2.=20
  Unfortunately, it won't be ready for another few weeks since I'm working =
on=20
  hardware images currently.</span></font></div>
  <div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" face=3D"Arial"><s=
pan class=3D"EC_EC_188023817-21012008"></span></font>&nbsp;</div>
  <div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" face=3D"Arial"><s=
pan class=3D"EC_EC_188023817-21012008">-- Mike</span></font></div><font col=
or=3D"#0000ff" face=3D"Arial"></font><br>
  <div class=3D"EC_EC_OutlookMessageHeader" dir=3D"ltr" align=3D"left" lang=
=3D"en-us">
  <hr>
  <font face=3D"Tahoma"><b>From:</b> Mohammad Sadegh Sadri=20
  [mailto:mamsadegh@hotmail.com] <br><b>Sent:</b> Monday, January 21, 2008 =
3:54=20
  AM<br><b>To:</b> David Baird; linuxppc-embedded@ozlabs.org<br><b>Subject:=
</b>=20
  RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC<br></font><br></div>
  <div></div>thanks for you reply david,<br><br>As far as I know the Linux=
=20
  driver for Xilinx PLB TEMAC was two parts : 1- adapter.c and 2- the rest =
of=20
  the driver files<br><br>Only adapter.c was really a linux related file an=
d the=20
  rest of the files were Xilinx generic driver code for PLB=20
  TEMAC.<br><br>correct?<br><br>then now, I know EDK 9.2 generates the need=
ed=20
  Linux support package and needed related files, so if this is the case ca=
n we=20
  use these files as the needed driver in our linux kernel?<br><br>by the w=
ay, i=20
  did never hear about this git repository before...can you describe us, wh=
ere=20
  is it and how we can access it and which projects are now hosted by=20
  it?<br><br><br>thanks<br><br><br>&gt; Date: Mon, 21 Jan 2008 00:54:30=20
  -0700<br>&gt; From: dhbaird@gmail.com<br>&gt; To:=20
  mamsadegh@hotmail.com<br>&gt; Subject: Re: Xilinx XPS_LL_TEMAC vs=20
  PLB_TEMAC<br>&gt; <br>&gt; On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadr=
i=20
  &lt;mamsadegh@hotmail.com&gt; wrote:<br>&gt; &gt; As you know Xilinx PLB =
TEMAC=20
  is a module which connects Hard TEMAC in<br>&gt; &gt; Virtex-4 FX devices=
 to=20
  PLB bus,<br>&gt; &gt; now, in the new release of EDK , EDK 9.2 Xilinx has=
=20
  added a new interface<br>&gt; &gt; core , which is called XPS_LL_TEMAC an=
d has=20
  a different structure than<br>&gt; &gt; normal PLB TEMAC. spacially it ha=
s=20
  some additional data transfer buses.<br>&gt; &gt;<br>&gt; &gt; Now the=20
  question is,... is there any linux driver available for this new<br>&gt; =
&gt;=20
  core?<br>&gt; <br>&gt; Yes there is, but I had to use the git sources=20
  at:<br>&gt; <br>&gt; git.xilinx.com<br><br>
  <hr>
  <a href=3D"http://" target=3D"_blank"></a></blockquote><br>
<hr>
<a href=3D"http://" target=3D"_blank"></a>
</blockquote><br /><hr /> <a href=3D'' target=3D'_new'></a></body>
</html>=

--_51985bad-c31e-46bd-a04f-43e09a27939e_--
