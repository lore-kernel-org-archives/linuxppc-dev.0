Return-Path: <srivatsan@deccanetworld.com>
Received: from gatekeeper.deccanetworld.com (mail.deccanetworld.com
	[203.196.146.50])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBD602BF14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 16:08:38 +1100 (EST)
Received: from gatekeeper.deccanetworld.com (localhost [127.0.0.1])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id iBU4ucv5001929
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Dec 2004 10:26:38 +0530
Received: from mail.deccanetworld.com (server.deccanetworld.com [192.168.1.32])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id iBU4uWRq000922
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Dec 2004 10:26:32 +0530
Received: (from root@localhost)
	by mail.deccanetworld.com (8.11.0/8.11.0) id iBU5P2828962
	for linuxppc-embedded@ozlabs.org; Thu, 30 Dec 2004 10:55:02 +0530
Received: from bgcw301 ([10.203.105.18])
	by mail.deccanetworld.com (8.11.0/8.11.0) with ESMTP id iBU5P2Y28920
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Dec 2004 10:55:02 +0530
From: "Srivatsan" <srivatsan@deccanetworld.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 30 Dec 2004 10:34:11 +0530
Message-ID: <000401c4ee2d$00355250$1269cb0a@bgcw301>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C4EE5B.19ED8E50"
In-Reply-To: <20041230010007.B9EC22BF17@ozlabs.org>
Subject: Linux-ppc boot problems
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

------=_NextPart_000_0005_01C4EE5B.19ED8E50
Content-Type: text/plain;
Content-Transfer-Encoding: 7bit

Hi all,
 
    I am sending the whole logbuffer. 
 
00138BD4: 3C 36 3E 4D 65 6D 6F 72  79 20 42 41 54 20 6D 61 |<6>Memory
BATma|
00138BE4: 70 70 69 6E 67 3A 20 42  41 54 32 3D 31 36 4D 62
|pping:BAT2=16Mb|
00138BF4: 2C 20 42 41 54 33 3D 30  4D 62 2C 20 72 65 73 69 |,
BAT3=0Mb,resi|
00138C04: 64 75 61 6C 3A 20 30 4D  62 0A 00 00 00 00 00 00
|dual:0Mb.......|
00138C14: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C24: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C34: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C44: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C54: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C64: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C74: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C84: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138C94: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138CA4: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138CB4: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|...............|
00138CC4: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
|............... 
 
 
Any pointers to the above problem. I am not able to see further logs, Is
it that our Linux Kernel is not properly ported? We have been on this
problem for quite some time now, kindly help us to get our system up.
 
Thanking you all for your support.
 
With Best Regards,
C.R.Srivatsan
 
 
 
 


********************************DISCLAIMER**********************************

This e-mail and any attachment is for authorised use by the intended
recipient(s) only. It may contain proprietary material, confidential
information and/or be subject to legal privilege of Deccanet Designs Ltd.
If you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that
you are strictly prohibited from retaining, using, copying, altering or
disclosing the contents of this message.

****************************************************************************
------=_NextPart_000_0005_01C4EE5B.19ED8E50
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C4EE5A.DDC614B0">
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
</xml><![endif]-->
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
bold'>Hi all,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></b></p>=


<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>I am =
sending the
whole logbuffer. <o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></b></p>=


<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138BD4: 3C 36 3E 4D 65 6D 6F 72<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>79 20 42 41 54 20 6D 61 =
|&lt;6&gt;Memory<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>BATma|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138BE4: 70 70 69 6E 67 3A 20 42<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>41 54 32 3D 31 36 4D 62<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|pping:BAT2=3D16Mb|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138BF4: 2C 20 42 41 54 33 3D 30<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>4D 62 2C 20 72 65 73 69 |,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>BAT3=3D0Mb,resi|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C04: 64 75 61 6C 3A 20 30 4D<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>62 0A 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|dual:0Mb.......|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C14: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C24: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C34: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C44: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C54: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C64: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C74: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C84: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138C94: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138CA4: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138CB4: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|...............|<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>00138CC4: 00 00 00 00 00 00 00 00<span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>00 00 00 00 00 00 00<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>|............... <o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></b></p>=


<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></b></p>=


<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Any pointers to the above problem. I am not able to see further =
logs, <span
class=3DGramE>Is</span> it that our Linux Kernel is not properly ported? =
We have
been on this problem for quite some time now, kindly help us to get our =
system
up.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Thanking you all for your
support.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></b></p>=


<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>With Best Regards,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>C.R.Srivatsan<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></b></p>=


<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

</div>


<PRE>

********************************DISCLAIMER**********************************

This e-mail and any attachment is for authorised use by the intended
recipient(s) only. It may contain proprietary material, confidential
information and/or be subject to legal privilege of Deccanet Designs Ltd.
If you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that
you are strictly prohibited from retaining, using, copying, altering or
disclosing the contents of this message.

****************************************************************************
</pre>
</body>

</html>

------=_NextPart_000_0005_01C4EE5B.19ED8E50--
