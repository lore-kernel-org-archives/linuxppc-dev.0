Return-Path: <tmarri@apm.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	by ozlabs.org (Postfix) with SMTP id AE9F4B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 08:05:09 +1000 (EST)
Received: by qwi2 with SMTP id 2so1828814qwi.34
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 15:05:06 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
MIME-Version: 1.0
Date: Tue, 17 Aug 2010 15:05:05 -0700
Message-ID: <5c9e5627d7150addd7801c637a8867d8@mail.gmail.com>
Subject: "make uImage" issue with new kernels
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd5f63c420bf3048e0c24cc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd5f63c420bf3048e0c24cc
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I am seeing weird issue with latest  kernel. =93make uImage=94 failes with =
=93no
rule to make target=94 error message.

Has anything changed recently ?



-----------msg --------

{tmarri@svdclab61}> make 44x/canyonlands_defconfig

#

# configuration written to .config

#

{tmarri@svdclab61}> make uImage

scripts/kconfig/conf --silentoldconfig arch/powerpc/Kconfig

make: *** No rule to make target `uImage'.  Stop.

{tmarri@svdclab61}>



------------



-marri

--000e0cd5f63c420bf3048e0c24cc
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

<p class=3D"MsoNormal">I am seeing weird issue with latest=A0 kernel. =93ma=
ke
uImage=94 failes with =93no rule to make target=94 error message.</p>

<p class=3D"MsoNormal">Has anything changed recently ?</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">-----------msg --------</p>

<p class=3D"MsoNormal">{tmarri@svdclab61}&gt; make 44x/canyonlands_defconfi=
g</p>

<p class=3D"MsoNormal">#</p>

<p class=3D"MsoNormal"># configuration written to .config</p>

<p class=3D"MsoNormal">#</p>

<p class=3D"MsoNormal">{tmarri@svdclab61}&gt; make uImage</p>

<p class=3D"MsoNormal">scripts/kconfig/conf --silentoldconfig arch/powerpc/=
Kconfig</p>

<p class=3D"MsoNormal">make: *** No rule to make target `uImage&#39;.=A0 St=
op.</p>

<p class=3D"MsoNormal">{tmarri@svdclab61}&gt;</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">------------</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">-marri</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

<p class=3D"MsoNormal">=A0</p>

</div>

</body>

</html>

--000e0cd5f63c420bf3048e0c24cc--
