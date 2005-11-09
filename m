Return-Path: <joachim.denil@telenet.be>
From: "Joachim Denil" <joachim.denil@telenet.be>
To: <Linuxppc-dev@ozlabs.org>
Date: Wed, 9 Nov 2005 10:57:16 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C5E51C.59221CE0"
Message-Id: <20051109095645.75D1D380BC@astra.telenet-ops.be>
Subject: Platform specific code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C5E51C.59221CE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear group,
 
For an internship i have to embed linux to a custom made board. It's based
on IBM powerpc 405gp with 64 MB Ram and 8 MB flash memory, a couple of
serial ports,.
In the arch/ppc/platform tree I probably have to write code for the custom
board. But what does the code has to do. Can someone give me some pointers
to what the code should do? I can't find documentation about it.
 
Thank you,
 
Joachim Denil
Student Karel de Grote Hogeschool Antwerpen. 

------=_NextPart_000_0000_01C5E51C.59221CE0
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C5E51C.58E8E470">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:DontDisplayPageBoundaries/>
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dear group,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>For an internship i =
have to
embed linux to a custom made board. It&#8217;s based on IBM powerpc =
405gp with 64
MB Ram and 8 MB flash memory, a couple of serial =
ports,&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>In the =
arch/ppc/platform tree
I probably have to write code for the custom board. But what does the =
code has
to do. Can someone give me some pointers to what the code should do? I =
can&#8217;t
find documentation about it.<o:p></o:p></span></font></p>

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
font-family:Arial'>Student Karel de Grote Hogeschool Antwerpen. =
<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C5E51C.59221CE0--
