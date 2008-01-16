Return-Path: <kannappan@tesbv.com>
Received: from hermes.tesbv.com (hermes.tesbv.com [213.215.41.187])
	by ozlabs.org (Postfix) with ESMTP id 531BCDDE27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 20:13:57 +1100 (EST)
Received: from ganga.tes (unknown [10.20.0.1])
	by hermes.tesbv.com (Postfix) with ESMTP id 28A4AF4703
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 09:52:19 +0100 (CET)
Received: from Kanslaptop (unknown [10.20.0.41])
	by ganga.tes (Postfix) with ESMTP id 5B52F5C43AF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 14:16:53 +0530 (IST)
From: "kannappan" <kannappan@tesbv.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: PPC440SPe: generating PCIe INTx 
Date: Wed, 16 Jan 2008 14:16:44 +0530
Message-ID: <003601c8581c$55f27220$2900140a@Kanslaptop>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0037_01C8584A.6FAAAE20"
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

------=_NextPart_000_0037_01C8584A.6FAAAE20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello All,
 
I would like to know how to generate PCIe INTx interrupt from Legacy
PCIe EP in PPC440SPe.
 
Also, please clarify,
Page 741 of the user manual (PPC440SPe_UM2014_V1_26.pdf) write
Assert_INTx message to INT_ADDR[61:63].
Page 739, table 27-9, mentions, Assert_INTA by writing to Outbound GBIF
write channel 9, A[52:59]=0x20.
 
Whether the INT_ADDR is any addresses BAR3 / POM3 address?
What is the Assert_INTx value to be written to INT_ADDR[61:63]?  How do
I correlate with the message code values given in PCI express system
architecture?
 
The message codes given in PCI express system architecture is as follows
 

INTx Messages
Message Code

Assert_INTA
0010 0000

Assert_INTB
0010 0001

Assert_INTC
0010 0010

Assert_INTD
0010 0011

Deassert_INTA
0010 0100

Deassert_INTB
0010 0101

Deassert_INTC
0010 0110

Deassert_INTD
0010 0111
 
 
Regards,
Kans.

------=_NextPart_000_0037_01C8584A.6FAAAE20
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C8584A.6C2B2450">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place" downloadurl=3D"http://www.5iantlavalamp.com/"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
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
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;
	mso-font-alt:"\FF2D\FF33 \660E\671D";
	mso-font-charset:128;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:1 134676480 16 0 131072 0;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:128;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:1 134676480 16 0 131072 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"MS Mincho";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
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
p.doctext, li.doctext, div.doctext
	{mso-style-name:doctext;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"MS Mincho";}
span.docemphstrong
	{mso-style-name:docemphstrong;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I would like to know how to generate <span =
class=3DSpellE>PCIe</span>
<span class=3DSpellE>INTx</span> interrupt from Legacy <span =
class=3DSpellE>PCIe</span>
EP in PPC440SPe.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Also, please clarify,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Page 741 of the user manual =
(PPC440SPe_UM2014_V1_26.pdf) write
Assert_INTx message to INT_<span =
class=3DGramE>ADDR[</span>61:63].<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Page 739, table 27-9, mentions, <span =
class=3DSpellE>Assert_INTA</span>
by writing to Outbound GBIF write channel 9, <span =
class=3DGramE>A[</span>52:59]=3D0x20.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Whether the INT_ADDR is any addresses BAR3 / POM3 =
address?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What is the Assert_INTx value to be written to =
INT_<span
class=3DGramE>ADDR[</span>61:63]?<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>How
do I correlate with the message code values given in PCI express system =
architecture?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The message codes given in PCI express system =
architecture
is as follows<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<table class=3DMsoNormalTable border=3D1 cellspacing=3D0 cellpadding=3D0 =
width=3D"100%"
 style=3D'width:100.0%;mso-cellspacing:0in;mso-padding-alt:3.0pt 3.0pt =
3.0pt 3.0pt'>
 <thead>
  <tr style=3D'mso-yfti-irow:0'>
   <td style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
   <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><span
   class=3Ddocemphstrong><b><font size=3D3 color=3Dwhite face=3D"Times =
New Roman"><span
   =
style=3D'font-size:12.0pt;color:white;background:#316AC5;font-weight:bold=
'>INTx</span></font></b></span></span><span
   class=3Ddocemphstrong><b><span style=3D'font-weight:bold'> =
Messages</span></b></span><b><span
   style=3D'font-weight:bold'><o:p></o:p></span></b></p>
   </td>
   <td style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
   <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span
   class=3Ddocemphstrong><b><font size=3D3 face=3D"Times New =
Roman"><span
   style=3D'font-size:12.0pt;font-weight:bold'>Message =
Code</span></font></b></span><b><span
   style=3D'font-weight:bold'><o:p></o:p></span></b></p>
   </td>
  </tr>
 </thead>
 <tr style=3D'mso-yfti-irow:1'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Assert_INTA</span></font></span><o:p></o:p></p=
>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 =
0000<o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr style=3D'mso-yfti-irow:2'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Assert_INTB</span></font></span><o:p></o:p></p=
>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 =
0001<o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr style=3D'mso-yfti-irow:3'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Assert_INTC</span></font></span><o:p></o:p></p=
>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 <span
  class=3DSpellE>0010</span><o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr style=3D'mso-yfti-irow:4'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Assert_INTD</span></font></span><o:p></o:p></p=
>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 =
0011<o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr style=3D'mso-yfti-irow:5'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Deassert_INTA</span></font></span><o:p></o:p><=
/p>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 =
0100<o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr style=3D'mso-yfti-irow:6'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Deassert_INTB</span></font></span><o:p></o:p><=
/p>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 =
0101<o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr style=3D'mso-yfti-irow:7'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Deassert_INTC</span></font></span><o:p></o:p><=
/p>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 =
0110<o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr style=3D'mso-yfti-irow:8;mso-yfti-lastrow:yes'>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><span =
class=3DSpellE><font
  size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Deassert_INTD</span></font></span><o:p></o:p><=
/p>
  </td>
  <td valign=3Dtop style=3D'padding:3.0pt 3.0pt 3.0pt 3.0pt'>
  <p class=3Ddoctext align=3Dcenter style=3D'text-align:center'><font =
size=3D3
  face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>0010 =
0111<o:p></o:p></span></font></p>
  </td>
 </tr>
</table>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:State><st1:place><font size=3D2 =
face=3DArial><span
  =
style=3D'font-size:10.0pt;font-family:Arial'>Kans.</span></font></st1:pla=
ce></st1:State><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------=_NextPart_000_0037_01C8584A.6FAAAE20--
