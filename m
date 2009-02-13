Return-Path: <ArunR@aaesys.com>
Received: from AAE-Exch.aaesys.com (mail.aaesys.com [67.131.247.41])
	by ozlabs.org (Postfix) with ESMTP id 12D8ADDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 04:43:48 +1100 (EST)
From: Arun Roy <ArunR@aaesys.com>
To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Date: Fri, 13 Feb 2009 09:38:19 -0800
Subject: MPC8248 IDMA PCI burst
Message-ID: <2DE723F44CAFD24A9B6BF606813F010C2255E5A9@aae-exch>
Content-Type: multipart/alternative;
	boundary="_000_2DE723F44CAFD24A9B6BF606813F010C2255E5A9aaeexch_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_2DE723F44CAFD24A9B6BF606813F010C2255E5A9aaeexch_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am having some problem with the PCI burst using the MPC8248 IDMA feature.=
 I can get a continuous burst of 2k when transferring data from the system =
memory to the PCI direction but in the other direction (i.e. PCI to system =
memory) the PCI burst is fragmented with 32 bytes of fragment.  I have veri=
fied that the Prefetch bit is set in the POCMR register.

Here are my settings :


DCM : DMA_WRAP=3D101, SINC=3D1, DINC=3D1, S/D=3D00

STS: 2016

SS_MAX: 2016

BUF_INV: 2048

DTS: 2016



Transfer buffer size is 2048 bytes



BD flags : V=3D1, W=3D1, I=3D1, L=3D1, BD Len =3D 1024



Any help will be appreciated.



Thanks

-Arun


--_000_2DE723F44CAFD24A9B6BF606813F010C2255E5A9aaeexch_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
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

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I am having some problem with the PCI burst using the
MPC8248 IDMA feature. I can get a continuous burst of 2k when transferring =
data
from the system memory to the PCI direction but in the other direction (i.e=
.
PCI to system memory) the PCI burst is fragmented with 32 bytes of fragment=
. &nbsp;I
have verified that the Prefetch bit is set in the POCMR register.<o:p></o:p=
></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Here are my settings :<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>DCM : DMA_WRAP=3D101, SINC=3D1, DINC=3D1, S/D=3D00<=
o:p></o:p></p>

<p class=3DMsoPlainText>STS: 2016<o:p></o:p></p>

<p class=3DMsoPlainText>SS_MAX: 2016<o:p></o:p></p>

<p class=3DMsoPlainText>BUF_INV: 2048<o:p></o:p></p>

<p class=3DMsoPlainText>DTS: 2016<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Transfer buffer size is 2048 bytes<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>BD flags : V=3D1, W=3D1, I=3D1, L=3D1, BD Len =3D 1=
024<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Any help will be appreciated.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Thanks<o:p></o:p></p>

<p class=3DMsoPlainText>-Arun<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_2DE723F44CAFD24A9B6BF606813F010C2255E5A9aaeexch_--
