Return-Path: <srivatsan@deccanetworld.com>
Received: from gatekeeper.deccanetworld.com (unknown [61.95.203.221])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 125C467A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 23:44:12 +1100 (EST)
Received: from gatekeeper.deccanetworld.com (localhost [127.0.0.1])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id j1OAxM4m005161
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Feb 2005 16:29:22 +0530
Received: from mail.deccanetworld.com (server.deccanetworld.com [192.168.1.32])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id j1OAxMkG005156
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Feb 2005 16:29:22 +0530
From: "Srivatsan" <srivatsan@deccanetworld.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 24 Feb 2005 18:04:54 +0530
Message-ID: <000301c51a6d$3f06b9d0$1269cb0a@bgcw301>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C51A9B.58C3B0C0"
In-Reply-To: <20050224121917.D60E867A99@ozlabs.org>
Subject: Linuxppc-embedded Digest, Vol 6, Issue 54
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

------=_NextPart_000_0004_01C51A9B.58C3B0C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
 
As I am not sure of the cause of the below mentioned error, I have
mailed this to both uboot and LinuxPPC group. 
 
We are trying to port linux 2.4.20 for the mpc8280 Rattler board. Kernel
boot seems to stop after printing "Now booting the kernel".
 
But from the log buffer(Starting at 0x194654) dump it looks like it is
well crossing this stage.
 
The last message that was dumped in the log buffer is:
 
00194EB4: 3C 34 3E 65 74 68 30 3A  20 63 6F 6E 66 69 67 3A  |<4>eth0:
config:|
00194EC4: 20 61 75 74 6F 2D 6E 65  67 6F 74 69 61 74 69 6F  | auto-
negotiatio|
00194ED4: 6E 20 6F 6E 2C 20 31 30  30 48 44 58 2C 20 31 30  |n on,
100HDX, 10|
00194EE4: 48 44 58 2E 0A 00 00 00  00 00 00 00 00 00 00 00  |
HDX.............|
00194EF4: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|................|
 
The boot loader used is u-boot.
 
Any pointers to why messages after "Now booting the kernel" are not
getting on to the console ?.Is it that I am missing some patch? 
Thanks everybody for your time.
 
 
regards,
C.R.Srivatsan
 

------=_NextPart_000_0004_01C51A9B.58C3B0C0
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C51A9B.565A2AD0">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName" downloadurl=3D"http://www.microsoft.com"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
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
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";
	font-weight:bold;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	font-weight:bold;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;
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

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Hi,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>As I am not sure of the cause of the below mentioned error, I have =
mailed
this to both uboot and <span class=3DSpellE>LinuxPPC</span> group. =
<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>We are trying to port linux 2.4.20 for the mpc8280 Rattler board. =
Kernel
boot seems to stop after printing &quot;Now booting the =
kernel&quot;.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>But from the log <span class=3DGramE>buffer(</span>Starting at =
0x194654)
dump it looks like it is<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>well crossing this stage.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>The last message that was dumped in the log buffer =
is:<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00194EB4: 3C 34 3E 65 74 68 30 3A<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>20 63 6F 6E 66 69 67 3A<span style=3D'mso-spacerun:yes'>&nbsp;
</span>|&lt;4&gt;eth0:<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>config:|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00194EC4: 20 61 75 74 6F 2D 6E 65<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>67 6F 74 69 61 74 69 6F<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>|
auto-<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>negotiatio|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00194ED4: 6E 20 6F 6E 2C 20 31 30<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>30 48 44 58 2C 20 31 30<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>|n
on,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>100HDX, 10|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00194EE4: 48 44 58 2E 0A 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>HDX.............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00194EF4: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|................|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>The boot loader used is u-boot.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Any pointers to why messages after &quot;Now booting the =
kernel&quot; are
not<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><span class=3DGramE><b =
style=3D'mso-ansi-font-weight:normal'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;
mso-bidi-font-weight:bold'>getting</span></font></b></span><span
style=3D'font-weight:normal;mso-bidi-font-weight:bold'> on to the =
console ?.Is it
that I am missing some patch? <o:p></o:p></span></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Thanks everybody for your time.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>regards,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>C.R.</span></font></b><st1:PersonName
style=3D"BACKGROUND-POSITION: left bottom; BACKGROUND-IMAGE: =
url(res://ietag.dll/#34/#1001); BACKGROUND-REPEAT: repeat-x"><span
 =
style=3D'font-weight:normal;mso-bidi-font-weight:bold'>Srivatsan</span></=
st1:PersonName><span
style=3D'font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span>=
</p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C51A9B.58C3B0C0--
