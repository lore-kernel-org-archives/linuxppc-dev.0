Return-Path: <yifei_wang@hotmail.com>
Received: from bay0-omc4-s1.bay0.hotmail.com (bay0-omc4-s1.bay0.hotmail.com
	[65.54.190.203]) by ozlabs.org (Postfix) with ESMTP id D5A9BB6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 01:54:48 +1100 (EST)
Message-ID: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>
From: WANG YiFei <yifei_wang@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: ppc405 + MCP23S17
Date: Tue, 12 Oct 2010 22:49:41 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00C8_01CB6A5F.C22F2CA0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_NextPart_000_00C8_01CB6A5F.C22F2CA0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I'm a newbie for linux device driver development.

We have a custom ppc405 board which has MCP23S17

(16-Bit I/O Expander with SPI Interface) on it.

I noticed that current kernel has MCP23S08 driver

support, I'd like to know:

1. if passing platform data to MCP23S08 driver, can it make

   MCP23S17 work?

2. Generally, I'd like to know how to pass platform data to

   a particular device driver. In my mind, platform data should

   not be in driver code, right? However, I don't know where is

   the suitable place to pass platform data to driver.

3. How to describe this in dts file?

 

Thanks in advance,

YiFei


------=_NextPart_000_00C8_01CB6A5F.C22F2CA0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	margin:0cm;
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
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
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

<div class=3DWordSection1>

<p class=3DMsoPlainText>Hi,<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>I'm a newbie for linux device driver =
development.<o:p></o:p></p>

<p class=3DMsoPlainText>We have a custom ppc405 board which has =
MCP23S17<o:p></o:p></p>

<p class=3DMsoPlainText>(16-Bit I/O Expander with SPI Interface) on =
it.<o:p></o:p></p>

<p class=3DMsoPlainText>I noticed that current kernel has MCP23S08 =
driver<o:p></o:p></p>

<p class=3DMsoPlainText>support, I'd like to know:<o:p></o:p></p>

<p class=3DMsoPlainText>1. if passing platform data to MCP23S08 driver, =
can it
make<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp; MCP23S17 work?<o:p></o:p></p>

<p class=3DMsoPlainText>2. Generally, I'd like to know how to pass =
platform data
to<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp; a particular device driver. In my =
mind,
platform data should<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp; not be in driver code, right? =
However, I
don't know where is<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp; &nbsp;the suitable place to pass platform =
data to
driver.<o:p></o:p></p>

<p class=3DMsoPlainText>3. How to describe this in dts =
file?<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Thanks in advance,<o:p></o:p></p>

<p class=3DMsoNormal>YiFei<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_00C8_01CB6A5F.C22F2CA0--
