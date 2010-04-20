Return-Path: <nhillery@sixisinc.com>
Received: from asp.reflexion.net (asp-submit.reflexion.net [69.84.129.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27C1AB7CF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 04:35:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAE0B6.C010F2A1"
Subject: U-boot support for MPC85xx eSPI
Date: Tue, 20 Apr 2010 14:24:37 -0400
Message-ID: <DA601BED1671C24093F284F75082C9934B68EB@rtpwbee01.SIXIS.NS>
From: "Hillery, Nathan" <nhillery@sixisinc.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAE0B6.C010F2A1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm looking for U-boot support for the embedded SPI driver on the
MPC8536 to access a SPI flash device (Numonyx [ex-STmicro] M25P16).  The
eSPI can read the SPI flash (that's how U-boot gets loaded into RAM) and
I can read/write from linux using the mtdblock driver.  I see code that
appears to support the MPC83xx, but it looks quite different than the
MPC85xx.  I am willing to backport the linux code to work in U-boot, but
am hoping that isn't necessary.


------_=_NextPart_001_01CAE0B6.C010F2A1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>I&#8217;m looking for U-boot support for the =
embedded SPI
driver on the MPC8536 to access a SPI flash device (Numonyx [ex-STmicro] =
M25P16).&nbsp;
The eSPI can read the SPI flash (that&#8217;s how U-boot gets loaded =
into RAM)
and I can read/write from linux using the mtdblock driver.&nbsp; I see =
code that
appears to support the MPC83xx, but it looks quite different than the
MPC85xx.&nbsp; I am willing to backport the linux code to work in =
U-boot, but am
hoping that isn&#8217;t necessary.<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CAE0B6.C010F2A1--
