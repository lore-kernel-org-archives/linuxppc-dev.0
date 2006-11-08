Return-Path: <jqiang@haliplex.com>
Received: from hellskitchen.haliplex.com.au
	(dsl-202-45-109-210-static.VIC.netspace.net.au [202.45.109.210])
	by ozlabs.org (Postfix) with ESMTP id 6222267CC9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 13:13:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C702DA.3F9E7833"
Subject: IDMA IN MPC82XX (i.e mpc8272)
Date: Wed, 8 Nov 2006 13:04:39 +1100
Message-ID: <32A7B31E4005134E8BA805EBAAFB9DCD9C7A47@hellskitchen.haliplex.com.au>
From: "Jonathan Qiang" <jqiang@haliplex.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C702DA.3F9E7833
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Any one who has any experience when using IDMA on mpc82xx?=20
Currently, the status what I have got is, memory-to-memory mode, both
Data bus had been set to 60x-bus, which means DDTB and SDTB are working
on 60x-bus. if set DMA_WRAP in DCM as 64-byte, SS_MAX,STS and DTS in
(IDMA Parameter RAM) all to 32 Bytes, there working good!
But if set DMA_WRAP more than 64-byte(i.e 256-bytes) ,SS_MAX,STS and DTS
in (IDMA Parameter RAM) all to 7*32 Bytes when WRAP =3D 256 . then got
some issues:
1. some bytes in a packet had been changed oddly. for example if  some
bytes in the packet is "20 0f 17 2c...." after=20
IDMA transmission , the bytes will be changed as "20 1d 17 2c", there is
a slightly different with "17" and "1d".
2. some bytes had been swapped , for example "20 0f 17 2c" , after
transmission , the bytes in packet was "2c 17 0f 20".
Any ideas?=20
Is this the cache issue? I had enabled the snooping
=20

------_=_NextPart_001_01C702DA.3F9E7833
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C70336.73084E70">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:\5B8B\4F53;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 135135232 16 0 262145 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:SimSun;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:SimSun;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Any one who has any experience when using IDMA on mpc82xx? <br>
Currently, the status what I have got is, memory-to-memory mode, both =
Data bus
had been set to 60x-bus, which means DDTB and SDTB are working on =
60x-bus. <span
class=3DGramE>if</span> set DMA_WRAP in DCM as 64-byte, SS_MAX,STS and =
DTS in
(IDMA Parameter RAM) all to 32 Bytes, there working good!<br>
But if set DMA_WRAP more than 64-<span class=3DGramE>byte(</span><span
class=3DSpellE>i.e</span> 256-bytes) ,SS_MAX,STS and DTS in (IDMA =
Parameter RAM)
all to 7*32 Bytes when WRAP =3D 256 . <span class=3DGramE>then</span> =
got some
issues:<br>
1. <span class=3DGramE>some</span> bytes in a packet had been changed =
oddly. <span
class=3DGramE>for</span> example if&nbsp; some bytes in the packet is =
&quot;20 0f
17 2c....&quot; after <br>
IDMA transmission , the bytes will be changed as &quot;20 1d 17 =
2c&quot;, there
is a slightly different with &quot;17&quot; and &quot;1d&quot;.<br>
2. <span class=3DGramE>some</span> bytes had been swapped , for example =
&quot;20
0f 17 2c&quot; , after transmission , the bytes in packet was &quot;2c =
17 0f
20&quot;.<br>
<span class=3DGramE>Any ideas?</span> <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Is this the cache issue? I had enabled the =
snooping<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C702DA.3F9E7833--
