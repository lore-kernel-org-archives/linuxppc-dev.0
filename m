Return-Path: <JohnsonCheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id B467868541
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 22:52:45 +1000 (EST)
From: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Tue, 11 Oct 2005 20:52:29 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_009F_01C5CEA5.B29A9CD0"
Message-Id: <20051011125245.B467868541@ozlabs.org>
Subject: make modules failed.
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

------=_NextPart_000_009F_01C5CEA5.B29A9CD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

When I install linux2.6 modules on powerpc, it's failed as following:

 

[root]# make ARCH=ppc CROSS_COMPILE=powerpc-linux-
INSTALL_MOD_PATH=/opt/cross-project/images/modules-2.6.12.3 modules

  INSTALL drivers/net/bonding/bonding.ko

  INSTALL drivers/usb/serial/usbserial.ko

  INSTALL drivers/usb/serial/visor.ko

  INSTALL fs/binfmt_misc.ko

  INSTALL fs/udf/udf.ko

  INSTALL lib/crc-ccitt.ko

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map
-b

/opt/cross-project/TS-101/images/modules-2.6.12.3 -r 2.6.12.3; fi

make: *** [_modinst_post] Error 139

[root]#

 

It seems that I can't use /sbin/depmod, because it's for x86. I am not sure.

How to fix it?

 

Thanks,

Johnson Cheng


------=_NextPart_000_009F_01C5CEA5.B29A9CD0
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
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chsdate" downloadurl=3D""/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#26032;&#32048;&#26126;&#39636;;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@&#26032;&#32048;&#26126;&#39636;";
	panose-1:2 2 3 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>When I install linux2.6 modules on powerpc, =
it&#8217;s
failed as following:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>[root]# make ARCH=3Dppc =
CROSS_COMPILE=3Dpowerpc-linux-
INSTALL_MOD_PATH=3D/opt/cross-project/images/modules-<st1:chsdate
IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" =
Year=3D"1899" w:st=3D"on">2.6.12</st1:chsdate>.3
modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; INSTALL =
drivers/net/bonding/bonding.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; INSTALL =
drivers/usb/serial/usbserial.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; INSTALL =
drivers/usb/serial/visor.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; INSTALL =
fs/binfmt_misc.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; INSTALL =
fs/udf/udf.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; INSTALL =
lib/crc-ccitt.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>if [ -r System.map -a -x /sbin/depmod ]; then
/sbin/depmod -ae -F System.map -b<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>/opt/cross-project/TS-101/images/modules-<st1:ch=
sdate
IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" =
Year=3D"1899" w:st=3D"on">2.6.12</st1:chsdate>.3
-r 2.6.12.3; fi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>make: *** [_modinst_post] Error =
139<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>[root]#<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>It seems that I can&#8217;t use /sbin/depmod, =
because it&#8217;s
for x86. I am not sure.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>How to fix it?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Johnson Cheng<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_009F_01C5CEA5.B29A9CD0--
