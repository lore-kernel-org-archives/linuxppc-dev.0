Return-Path: <tmarri@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	by ozlabs.org (Postfix) with SMTP id 7A4D8B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 09:59:47 +1100 (EST)
Received: by vws11 with SMTP id 11so115613vws.4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 15:59:44 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
MIME-Version: 1.0
Date: Thu, 14 Oct 2010 15:56:44 -0700
Message-ID: <6cfa2d1c7ecd946ea4acbd3077defa92@mail.gmail.com>
Subject: msi_bitmap.c question
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=90e6ba53a0e272a27104929baa5f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba53a0e272a27104929baa5f
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to resubmit a patch for MSI support for ppc4xx devices. One of
the review feedback was not to use the bit map as it is only for the device=
s
which don=92t have hard wired mapping between interrupt controller interrup=
ts
and MSI number. For example intr-ctrl0 interrupt 20 goes to MSI-0, interrup=
t
21 goes to MSI-1 ..etc. But when I checked  freescale SoCs and cell SoCs
they have interrupts hard wired to MSI interrupts.



Why do they have to use the bitmap and create irqhost, even though they are
one-to-one mapped between interrupt controller numbers and MSI ?



Thx,

Marri

--90e6ba53a0e272a27104929baa5f
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">

<div class=3D"Section1">

<p class=3D"MsoNormal">Hi,</p>

<p class=3D"MsoNormal">I am trying to resubmit a patch for MSI support for =
ppc4xx
devices. One of the review feedback was not to use the bit map as it is onl=
y
for the devices which don=92t have hard wired mapping between interrupt
controller interrupts and MSI number. For example intr-ctrl0 interrupt 20 g=
oes
to MSI-0, interrupt 21 goes to MSI-1 ..etc. But when I checked=A0 freescale=
 SoCs
and cell SoCs they have interrupts hard wired to MSI interrupts. =A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">Why do they have to use the bitmap and create irqhos=
t, even
though they are one-to-one mapped between interrupt controller numbers and =
MSI
?</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">Thx,</p>

<p class=3D"MsoNormal">Marri</p>

</div>

</body>

</html>

--90e6ba53a0e272a27104929baa5f--
