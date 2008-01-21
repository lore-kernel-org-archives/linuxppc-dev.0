Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s39.bay0.hotmail.com (bay0-omc1-s39.bay0.hotmail.com
	[65.54.246.111]) by ozlabs.org (Postfix) with ESMTP id 6C8AEDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 19:54:17 +1100 (EST)
Message-ID: <BAY115-W344A18C61627B3075C6281B23D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a6afac4b-c586-4228-b00b-4b43733c0fda_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: David Baird <dhbaird@gmail.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
Date: Mon, 21 Jan 2008 08:54:16 +0000
In-Reply-To: <440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com>
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl>
	<440abda90801202354l5a0ce4caq382af5991e36f775@mail.gmail.com>
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

--_a6afac4b-c586-4228-b00b-4b43733c0fda_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


thanks for you reply david,

As far as I know the Linux driver for Xilinx PLB TEMAC was two parts : 1- a=
dapter.c and 2- the rest of the driver files

Only adapter.c was really a linux related file and the rest of the files we=
re Xilinx generic driver code for PLB TEMAC.

correct?

then now, I know EDK 9.2 generates the needed Linux support package and nee=
ded related files, so if this is the case can we use these files as the nee=
ded driver in our linux kernel?

by the way, i did never hear about this git repository before...can you des=
cribe us, where is it and how we can access it and which projects are now h=
osted by it?


thanks


> Date: Mon, 21 Jan 2008 00:54:30 -0700
> From: dhbaird@gmail.com
> To: mamsadegh@hotmail.com
> Subject: Re: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
>=20
> On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> w=
rote:
> > As you know Xilinx PLB TEMAC is a module which connects Hard TEMAC in
> > Virtex-4 FX devices to PLB bus,
> > now, in the new release of EDK , EDK 9.2 Xilinx has added a new interfa=
ce
> > core , which is called XPS_LL_TEMAC and has a different structure than
> > normal PLB TEMAC. spacially it has some additional data transfer buses.
> >
> > Now the question is,... is there any linux driver available for this ne=
w
> > core?
>=20
> Yes there is, but I had to use the git sources at:
>=20
> git.xilinx.com

_________________________________________________________________


--_a6afac4b-c586-4228-b00b-4b43733c0fda_
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
thanks for you reply david,<br><br>As far as I know the Linux driver for Xi=
linx PLB TEMAC was two parts : 1- adapter.c and 2- the rest of the driver f=
iles<br><br>Only adapter.c was really a linux related file and the rest of =
the files were Xilinx generic driver code for PLB TEMAC.<br><br>correct?<br=
><br>then now, I know EDK 9.2 generates the needed Linux support package an=
d needed related files, so if this is the case can we use these files as th=
e needed driver in our linux kernel?<br><br>by the way, i did never hear ab=
out this git repository before...can you describe us, where is it and how w=
e can access it and which projects are now hosted by it?<br><br><br>thanks<=
br><br><br>&gt; Date: Mon, 21 Jan 2008 00:54:30 -0700<br>&gt; From: dhbaird=
@gmail.com<br>&gt; To: mamsadegh@hotmail.com<br>&gt; Subject: Re: Xilinx XP=
S_LL_TEMAC vs PLB_TEMAC<br>&gt; <br>&gt; On Jan 21, 2008 12:36 AM, Mohammad=
 Sadegh Sadri &lt;mamsadegh@hotmail.com&gt; wrote:<br>&gt; &gt; As you know=
 Xilinx PLB TEMAC is a module which connects Hard TEMAC in<br>&gt; &gt; Vir=
tex-4 FX devices to PLB bus,<br>&gt; &gt; now, in the new release of EDK , =
EDK 9.2 Xilinx has added a new interface<br>&gt; &gt; core , which is calle=
d XPS_LL_TEMAC and has a different structure than<br>&gt; &gt; normal PLB T=
EMAC. spacially it has some additional data transfer buses.<br>&gt; &gt;<br=
>&gt; &gt; Now the question is,... is there any linux driver available for =
this new<br>&gt; &gt; core?<br>&gt; <br>&gt; Yes there is, but I had to use=
 the git sources at:<br>&gt; <br>&gt; git.xilinx.com<br><br /><hr /> <a hre=
f=3D'' target=3D'_new'></a></body>
</html>=

--_a6afac4b-c586-4228-b00b-4b43733c0fda_--
