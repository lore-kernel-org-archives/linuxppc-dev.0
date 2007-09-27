Return-Path: <jhahn@bcfsemi.com>
Received: from raptor.bcfsemi.com (adsl-75-52-244-172.dsl.pltn13.sbcglobal.net
	[75.52.244.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D790DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 18:59:28 +1000 (EST)
Received: from jhahnPC (adsl-75-35-119-222.dsl.pltn13.sbcglobal.net
	[75.35.119.222]) (authenticated bits=0)
	by raptor.bcfsemi.com (8.13.8/8.13.8) with ESMTP id l8R8H2Rs004655
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Sep 2007 01:17:03 -0700
From: "John Hahn" <jhahn@bcfsemi.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Xilinx ML403 support in mainline u-boot 
Date: Thu, 27 Sep 2007 01:16:21 -0700
Message-ID: <000001c800de$b0baa1e0$122fe5a0$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C800A4.045BC9E0"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0001_01C800A4.045BC9E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello, I am a newbie about to start sw/hw development on ML403 based
systems.
 
I apologize if I am repeating a question already addressed in the forum, but
I have gone through past months of the archives without finding the answer.
 
Based on searching the archived posts
I have downloaded from Xilinx an older version of u-boot (1.1.4)
http://www.xilinx.com/ml410-p/designs/
<http://www.xilinx.com/ml410-p/designs/u-boot.zip> u-boot.zip
which appears to have the ml403 support.
 
I also cloned the latest u-boot repository from denx (1.3.0-rc2+)
git://www.denx.de/git/u-boot.git
 

However this tree does not appear to have the ml403 support.

If possible I would prefer to use the latest u-boot tree .

 

Its there another branch which I need to pull the ml403 support changes?

 

Thanks

 

John

 


------=_NextPart_000_0001_01C800A4.045BC9E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
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

<div class=3DSection1><pre>Hello, I am a newbie about to start sw/hw =
development on ML403 based =
systems.<o:p></o:p></pre><pre><o:p>&nbsp;</o:p></pre><pre>I apologize if =
I am repeating a question already addressed in the forum, but I have =
gone through past months of the archives without finding the =
answer.<o:p></o:p></pre><pre> <o:p></o:p></pre><pre>Based on searching =
the archived posts<o:p></o:p></pre><pre>I have downloaded from Xilinx an =
older version of u-boot (1.1.4)<o:p></o:p></pre><pre><a
href=3D"http://www.xilinx.com/ml410-p/designs/u-boot.zip" =
target=3D"_top">http://www.xilinx.com/ml410-p/designs/<b>u</b>-<b>boot</b=
>.<b>zip</b></a><o:p></o:p></pre><pre>which appears to have the ml403 =
support.<o:p></o:p></pre><pre><o:p>&nbsp;</o:p></pre><pre>I also cloned =
the latest u-boot repository from denx =
(1.3.0-rc2+)<o:p></o:p></pre><pre><a
href=3D"git://www.denx.de/git/u-boot.git">git://www.denx.de/git/u-boot.gi=
t</a><o:p></o:p></pre><pre><o:p>&nbsp;</o:p></pre>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>However
this tree does not appear to have the ml403 =
support.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>If
possible I would prefer to use the latest u-boot tree =
&#8230;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>Its
there another branch which I need to pull the ml403 support =
changes?<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Thanks<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>John<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C800A4.045BC9E0--
