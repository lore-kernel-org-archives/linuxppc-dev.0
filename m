Return-Path: <Srivatsan.CR@in.flextronics.com>
Received: from SGPMX1.asia.ad.flextronics.com (unknown [203.208.243.76])
	by ozlabs.org (Postfix) with ESMTP id 5C11E679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 17:41:31 +1000 (EST)
Message-ID: <3B58B875DBDE504F94D2A1A1C9DF6F1FD61A69@bglnt005.asia.ad.flextronics.com>
From: Srivatsan CR <Srivatsan.CR@in.flextronics.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 2 Jun 2005 13:11:26 +0530 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C56746.7B9DFBD0"
Subject: RE: Newbie question on Linux-PPC 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C56746.7B9DFBD0
Content-Type: text/plain

 
Hi all,
 
   Thanks everyone for the time. It's done and I have it working.
 
   I have another question regarding MAC address in Linux. I had ported
U-boot onto our customized board (MPC8280 based). It is working fine. I am
also able to boot a Linux Kernel. The Kernel version is Linux-2.4.20 . 
 
We set the MAC address for the board in U-boot as 00:FD:11:01:01:01. But
when the Linux Kernel boots it takes the MAC as 00:FD:81:01:01:01. 
 
I have confirmed that the U-boot passes the MAC address properly to the
Linux Kernel properly. Can anyone guide me to where to look out for the
issue stated above in the Linux code? 
 
Thanks everyone for the time. 
 
With Regards,
C.R.Srivatsan
 
 
 

------_=_NextPart_001_01C56746.7B9DFBD0
Content-Type: text/html
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C56774.92477130">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
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

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Hi all,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>Thanks =
everyone for
the time. It's done and I have it =
working.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>I have =
another
question regarding MAC address in Linux. I had ported U-boot onto our =
customized
board (MPC8280 based). It is working fine. I am also able to boot a =
Linux
Kernel. The Kernel version is Linux-2.4.20 . =
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
bold'>We set the MAC address for the board in U-boot as =
00:FD:</span></font></b><st1:time
Hour=3D"11" Minute=3D"1"><span =
style=3D'font-weight:normal;mso-bidi-font-weight:bold'>11:01:01:01</span=
></st1:time><span
style=3D'font-weight:normal;mso-bidi-font-weight:bold'>. But when the =
Linux
Kernel boots it takes the MAC as 00:FD:81:</span><st1:time Hour=3D"13" =
Minute=3D"1"><span
 =
style=3D'font-weight:normal;mso-bidi-font-weight:bold'>01:01:01</span></=
st1:time><span
style=3D'font-weight:normal;mso-bidi-font-weight:bold'>. =
<o:p></o:p></span></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>I have confirmed that the U-boot passes the MAC address properly =
to the
Linux Kernel properly. Can anyone guide me to where to look out for the =
issue
stated above in the Linux code? <o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Thanks everyone for the time. <o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>With Regards,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>C.R.Srivatsan<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt;mso-no-proof:yes'><o:p>&nbsp;</o:p></span></fo=
nt></b></p>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

</div>

</body>

</html>

------_=_NextPart_001_01C56746.7B9DFBD0--
