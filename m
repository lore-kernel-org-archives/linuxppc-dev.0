Return-Path: <joachim.denil@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id 4474868747
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 23:10:19 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id x3so1610485nzd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 04:10:19 -0800 (PST)
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 15 Nov 2005 13:03:51 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0036_01C5E9E5.073A21C0"
From: Joachim Denil <joachim.denil@gmail.com>
Message-ID: <4379ce76.65b4ffc2.2c64.274a@mx.gmail.com>
Subject: porting linux to new board type
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

------=_NextPart_000_0036_01C5E9E5.073A21C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
 
For an internship I have to port linux to custom made board. I assume I'll
have to set the memory-map right and make the hardware initialize, set IRQ,
.. Browsing trough the kernel source I found that all that happens within
/arch/ppc/platforms and there are separate files for each board. But how do
I start to write my own code. Can someone give me some pointers or is there
any documentation on this subject? This is what my board is made of:
 
*	64 Mb SDRAM (a PLD copy's the kernel to this location (0x00000000))
*	1 MB boot ram (a PLD copy's the boot loader from flash to this
location at the end of the memory map)
*	MMC card reader
*	Flash 8MB (don't have to use it though-> the PLD's use them to copy
boot loader and kernel there)
*	Leds that I can use through a PLD-register
 
The processor is a 405Gr processor, 1 UART is connected to a V24 iface.
The boot loader is a striped version of ppcboot, and is now used to load a
self written RTOS. So I guess I can use that version.
 
Is there besides this something else I 'll have to adjust? 
 
Thanks,
 
Joachim Denil
Student @ Karel De Grote hogeschool Antwerpen (Belgium)

------=_NextPart_000_0036_01C5E9E5.073A21C0
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C5E9E4.DFBFA020">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:DontDisplayPageBoundaries/>
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
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
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
 /* List Definitions */
 @list l0
	{mso-list-id:950630662;
	mso-list-type:hybrid;
	mso-list-template-ids:1501716094 1491915954 68354051 68354053 68354049 =
68354051 68354053 68354049 68354051 68354053;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Hi,<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>For an internship I =
have to
port <span class=3DSpellE>linux</span> to custom made board. I assume =
I&#8217;ll
have to set the memory-map right and make the hardware initialize, set =
<span
class=3DGramE>IRQ, &#8230;.</span> Browsing trough the kernel source I =
found that
all that happens within /arch/<span class=3DSpellE>ppc</span>/platforms =
and there
are separate files for each board. But how do I start to write my own =
code. Can
someone give me some pointers or is there any documentation on this =
subject? This
is what my board is made of:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<ul style=3D'margin-top:0cm' type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
36.0pt'><font
     size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
     Arial;mso-ansi-language:EN-GB'>64 Mb SDRAM (a PLD copy&#8217;s the =
kernel
     to this location (0x00000000))<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
36.0pt'><font
     size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
     Arial;mso-ansi-language:EN-GB'>1 MB boot ram (a PLD copy&#8217;s =
the boot
     loader from flash to this location at the end of the memory =
map)<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
36.0pt'><font
     size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
     Arial;mso-ansi-language:EN-GB'>MMC card =
reader<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
36.0pt'><font
     size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
     Arial;mso-ansi-language:EN-GB'>Flash 8MB (don&#8217;t have to use =
it though-&gt;
     the <span class=3DSpellE>PLD&#8217;s</span> use them to copy boot =
loader and
     kernel there)<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
36.0pt'><span
     class=3DSpellE><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
     =
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Leds</span></font></spa=
n><font
     size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
     Arial;mso-ansi-language:EN-GB'> that I can use through a =
PLD-register<o:p></o:p></span></font></li>
</ul>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>The processor is a =
405Gr
processor, 1 UART is connected to a V24 <span =
class=3DSpellE>iface</span>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>The boot loader is a =
striped
version of <span class=3DSpellE>ppcboot</span>, and is now used to load =
a self
written RTOS. So I guess I can use that =
version.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Is there besides this =
something
else <span class=3DGramE>I &#8216;<span class=3DSpellE>ll</span></span> =
have to adjust?
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Thanks,<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Joachim Denil<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Student @ <span class=3DSpellE>Karel</span> De Grote
hogeschool Antwerpen (<span =
class=3DSpellE>Belgium</span>)<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0036_01C5E9E5.073A21C0--
