Return-Path: <sunil.ayyapureddy@semindia.in>
Received: from almach.lunarpages.com (almach.lunarpages.com [209.200.240.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D79DDDF2F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 18:44:39 +1100 (EST)
Received: from [164.164.160.11] (helo=SunilA)
	by almach.lunarpages.com with esmtpa (Exim 4.63)
	(envelope-from <sunil.ayyapureddy@semindia.in>) id 1HCt5z-00013B-O6
	for linuxppc-embedded@ozlabs.org; Thu, 01 Feb 2007 23:44:36 -0800
From: "Sunil A" <sunil.ayyapureddy@semindia.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: Error:forced unwind support is required
Date: Fri, 2 Feb 2007 13:10:39 +0530
Message-ID: <KLECJOHKIJNMEKLBDEGEEEPFCDAA.sunil.ayyapureddy@semindia.in>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0052_01C746CB.8956C8E0"
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

------=_NextPart_000_0052_01C746CB.8956C8E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,
   Iam trying to build a  toolchain for powepc  and during the compliation
of glibc-2.3.3,I got stuck with the follwing error:

checking for forced unwind support... no
configure: error: forced unwind support is required

Iam using the follwing :
binutils-2.15
glibc-2.3.3
gcc-3.4.1
glibc-linuxthreads-2.3.3

I have tried googling,but couldn’t get any solution.

Can anybody direct me how to overcome the error??

Thanks



------=_NextPart_000_0052_01C746CB.8956C8E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 9">
<meta name=3DOriginator content=3D"Microsoft Word 9">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C746CB.8674B790">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
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
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;
	color:blue;}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;
	color:blue;}
span.EmailStyle15
	{mso-style-type:personal-compose;
	mso-ansi-font-size:12.0pt;
	mso-ascii-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;
	color:blue;}
span.EmailStyle17
	{mso-style-type:personal;
	mso-ansi-font-size:12.0pt;
	mso-ascii-font-family:"Times New Roman";
	mso-hansi-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;
	color:blue;}
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
</head>

<body lang=3DEN-US style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>Hi,<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'><span style=3D"mso-spacerun: yes">&nbsp;&nbsp; =
</span>Iam
trying to build a <span style=3D"mso-spacerun: =
yes">&nbsp;</span>toolchain for
powepc <span style=3D"mso-spacerun: yes">&nbsp;</span>and during the =
compliation
of glibc-2.3.3,I got stuck with the follwing =
error:<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New =
Roman"'>&nbsp;<o:p></o:p></span></font></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>checking for forced unwind support... =
no<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>configure: error: forced unwind support is =
required<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>&nbsp;<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>Iam using the follwing =
:<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>binutils-2.15<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>glibc-2.3.3<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>gcc-3.4.1<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>glibc-linuxthreads-2.3.3<o:p></o:p></span></font></b></=
span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>&nbsp;<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>I have tried googling,but couldn&#8217;t get any =
solution.<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>&nbsp;<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>Can anybody direct me how to overcome the =
error??<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>&nbsp;<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>Thanks<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle17><b><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;mso-bidi-font-family:"Times New Roman";
font-weight:bold'>&nbsp;<o:p></o:p></span></font></b></span></p>

<p class=3DMsoNormal><span class=3DEmailStyle15><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><![if =
!supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font></span></p>

</div>

</body>

</html>

------=_NextPart_000_0052_01C746CB.8956C8E0--
