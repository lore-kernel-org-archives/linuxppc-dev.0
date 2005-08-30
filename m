Return-Path: <JohnsonCheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 3ECDE68166
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 14:17:04 +1000 (EST)
From: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Tue, 30 Aug 2005 12:16:58 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_009C_01C5AD5C.B8704890"
Message-Id: <20050830041704.3ECDE68166@ozlabs.org>
Subject: Cross compile krb5 issue for ppc
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

------=_NextPart_000_009C_01C5AD5C.B8704890
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

When I cross compile krb5-1.4.1 for ppc on x86, I got the following error
message.

# cd krb5-1.4.1/src

#./configure -host=powerpc-linux

Checking for constructor/destructor attribute support. configure: error:
Cannot test for constructor/destructor support when cross compiling

 

Even if I have to some modifications to pass configure, but still cannot
make successfully.

Do anybody can give me advice or tell me where to get krb5 library for ppc?

 

Thanks,

Johnson Cheng


------=_NextPart_000_009C_01C5AD5C.B8704890
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
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
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
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
9.0pt;font-family:Arial'>When I cross compile krb5-<st1:chsdate
IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" =
Year=3D"1899" w:st=3D"on">1.4.1</st1:chsdate>
for ppc on x86, I got the following error =
message.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'># cd krb5-<st1:chsdate IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">1.4.1</st1:chsdate>/src<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>#./configure =
&#8211;host=3Dpowerpc-linux<o:p></o:p></span></font></p>

<p class=3DMsoNormal><i><font size=3D1 face=3DArial><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;font-style:italic'>Checking =
for
constructor/destructor attribute support&#8230; configure: error: Cannot =
test
for constructor/destructor support when cross =
compiling<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Even if I have to some modifications to pass =
configure,
but still cannot make successfully.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Do anybody can give me advice or tell me where =
to get
krb5 library for ppc?<o:p></o:p></span></font></p>

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

------=_NextPart_000_009C_01C5AD5C.B8704890--
