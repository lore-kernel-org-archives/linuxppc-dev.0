Return-Path: <ron_madrid@hotmail.com>
Received: from bay0-omc3-s33.bay0.hotmail.com (bay0-omc3-s33.bay0.hotmail.com
	[65.54.246.233]) by ozlabs.org (Postfix) with ESMTP id ED5EADDF00
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:13:12 +1000 (EST)
Message-ID: <BAY114-W16A6AFEF998AF39C8B2DD6F4D60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_31bfbc24-f39f-432d-8cf5-0ed502a3e7a3_"
From: Ronald Madrid <ron_madrid@hotmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: ifconfig MPC8313
Date: Tue, 6 May 2008 15:13:11 -0700
In-Reply-To: <4820D5E5.9030509@freescale.com>
References: <BAY114-W949ADEBC809E7A60716CCF4D60@phx.gbl>
	<4820CB5D.3000703@freescale.com>
	<BAY114-W46AEF8E266395E333E7FCF4D60@phx.gbl>
	<4820CF2A.5040301@freescale.com>
	<BAY114-W4066C5694CA67654680FB7F4D60@phx.gbl>
	<4820D11D.1050005@freescale.com>
	<BAY114-W13CCF7FDD3C01260AC40A9F4D60@phx.gbl>
	<4820D5E5.9030509@freescale.com>
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_31bfbc24-f39f-432d-8cf5-0ed502a3e7a3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you, that seems to have worked.  I can now ping and whatnot.  One que=
stion though.  I used the linux v2.6.20 that came with the BSP for the MPC8=
313ERDB and the ethernet worked.  Was there a bug earlier that would have a=
llowed this default .dts to work with my phy address of '0'?  I was rather =
baffled with this problem as the two dts files seemed to be more or less fu=
nctionally identical (2.6.20 from BSP vs. 2.6.25)

Ron

> Date: Tue, 6 May 2008 17:04:21 -0500
> From: scottwood@freescale.com
> To: ron_madrid@hotmail.com
> CC: linuxppc-dev@ozlabs.org
> Subject: Re: ifconfig MPC8313
>=20
> Ronald Madrid wrote:
> > I believe that it is zero.  Is that valid?
>=20
> FWIH, it's not recommended, as it's interpreted as a broadcast address=20
> in some cases.  However, if that's the way the board is, then go ahead=20
> and put a zero in the phy node's reg property.
>=20
> -Scott

_________________________________________________________________
Make Windows Vista more reliable and secure with Windows Vista Service Pack=
 1.
http://www.windowsvista.com/SP1?WT.mc_id=3Dhotmailvistasp1banner=

--_31bfbc24-f39f-432d-8cf5-0ed502a3e7a3_
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
<body class=3D'hmmessage'><div style=3D"text-align: left;">Thank you, that =
seems to have worked.&nbsp; I can now ping and whatnot.&nbsp; One question =
though.&nbsp; I used the linux v2.6.20 that came with the BSP for the MPC83=
13ERDB and the ethernet worked.&nbsp; Was there a bug earlier that would ha=
ve allowed this default .dts to work with my phy address of '0'?&nbsp; I wa=
s rather baffled with this problem as the two dts files seemed to be more o=
r less functionally identical (2.6.20 from BSP vs. 2.6.25)<br></div><br>Ron=
<br><br><hr id=3D"stopSpelling">&gt; Date: Tue, 6 May 2008 17:04:21 -0500<b=
r>&gt; From: scottwood@freescale.com<br>&gt; To: ron_madrid@hotmail.com<br>=
&gt; CC: linuxppc-dev@ozlabs.org<br>&gt; Subject: Re: ifconfig MPC8313<br>&=
gt; <br>&gt; Ronald Madrid wrote:<br>&gt; &gt; I believe that it is zero.  =
Is that valid?<br>&gt; <br>&gt; FWIH, it's not recommended, as it's interpr=
eted as a broadcast address <br>&gt; in some cases.  However, if that's the=
 way the board is, then go ahead <br>&gt; and put a zero in the phy node's =
reg property.<br>&gt; <br>&gt; -Scott<br><br /><hr />Make Windows Vista mor=
e reliable and secure with Windows Vista Service Pack 1. <a href=3D'http://=
www.windowsvista.com/SP1?WT.mc_id=3Dhotmailvistasp1banner' target=3D'_new'>=
Learn more.</a></body>
</html>=

--_31bfbc24-f39f-432d-8cf5-0ed502a3e7a3_--
