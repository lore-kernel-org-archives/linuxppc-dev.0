Return-Path: <joachim.denil@telenet.be>
Received: from hoboe1bl1.telenet-ops.be (hoboe1bl1.telenet-ops.be
	[195.130.137.72]) by ozlabs.org (Postfix) with ESMTP id 91FDD67C2D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 23:49:42 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe1bl1.telenet-ops.be (Postfix) with SMTP id C3032D41A7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 15:24:29 +0200 (CEST)
Received: from chimmiedesk (d54C0B51C.access.telenet.be [84.192.181.28])
	by hoboe1bl1.telenet-ops.be (Postfix) with ESMTP id 450E0D40BE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 15:24:29 +0200 (CEST)
From: "Joachim Denil" <joachim.denil@telenet.be>
To: <linuxppc-embedded@ozlabs.org>
Subject: problem booting custom board
Date: Wed, 12 Apr 2006 15:25:31 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0044_01C65E45.5643DC00"
Message-Id: <20060412132429.450E0D40BE@hoboe1bl1.telenet-ops.be>
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

------=_NextPart_000_0044_01C65E45.5643DC00
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear list,
 
When booting linux (2.6.12) on a custom board with a ppc405gp processor i
run in to some problems. The board's got 64 mb SDRAM at 0x00000000. The
board is booted with a stripped version of ppc-boot (I added a
board_information structure with the right values and placed the address in
gpr3) witch is located in SRAM, and then jumps to 0x0000 where I placed my
raw binary image. 
 
I made a platform file where I call: ppc4xx_intit, ppc4xx_setup_arch,
ppc4xx_map_io, and a function ppc405_map_irq, but with an empty table (no
PCI devices). I set the link/load address at 0x0 (where I placed my image)
and didn't touch the virtual address of the kernel base. As kernelargs I
gave console=ttyS0,9600, and my rootfs is a busybox in an initramfs.
 
Still I don't get anything on the UART (checked both in just in case) so
there is definitely something wrong. I only have 1 day in the week to work
on that and I have access to a BDI2000 to debug this Friday, so that should
give me some insights to where it all goes wrong.
 
But can someone tell me what I'm doing wrong? (or right just to give me some
hope after all ;) )
 
Thank you,
 
Joachim Denil
Student @ IWT-KDG Antwerpen Belgium

------=_NextPart_000_0044_01C65E45.5643DC00
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
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C65E45.56168A70">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:HyphenationZone>21</w:HyphenationZone>
  <w:EnvelopeVis/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseWord2002TableStyleRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.E-mailStijl17
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
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:Standaardtabel;
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=3DNL link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:35.4pt'>

<div class=3DSection1>

<p class=3DMsoNormal><span class=3DSpellE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Dear</span></font></span><fo=
nt
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> =
list,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>When booting <span
class=3DSpellE>linux</span> (2.6.12) on a custom board with a ppc405gp =
processor <span
class=3DSpellE>i</span> run in to some problems. The board&#8217;s got =
64 <span
class=3DSpellE>mb</span> SDRAM at 0x00000000. The board is booted with a =
stripped
version of <span class=3DSpellE>ppc</span>-boot (I added a <span =
class=3DSpellE>board_information</span>
structure with the right values and placed the address in gpr3) witch is
located in SRAM, and then jumps to 0x0000 where I placed my raw binary =
image. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>I made a platform file =
where I
call: ppc4xx_intit, ppc4xx_setup_arch, ppc4xx_map_io, and a function =
ppc405_map_irq,
but with an empty table (no PCI devices). I set the link/load address at =
0x0
(where I placed my image) and didn&#8217;t touch the virtual address of =
the
kernel base. As <span class=3DSpellE>kernelargs</span> I gave =
console=3DttyS0<span
class=3DGramE>,9600</span>, and my <span class=3DSpellE>rootfs</span> is =
a <span
class=3DSpellE>busybox</span> in an <span =
class=3DSpellE>initramfs</span>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Still I don&#8217;t =
get
anything on the UART (checked both in just in case) so there is =
definitely something
wrong. I only have 1 day in the week to work on that and I have access =
to a
BDI2000 to debug this Friday, so that should give me some insights to =
where it
all goes wrong.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>But can someone tell =
me what I&#8217;m
doing wrong? (<span class=3DGramE>or</span> right just to give me some =
hope after
all ;) )<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Thank =
you,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Joachim Denil<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Student @ <span class=3DSpellE>IWT-KDG</span> =
Antwerpen <span
class=3DSpellE>Belgium</span><o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0044_01C65E45.5643DC00--
