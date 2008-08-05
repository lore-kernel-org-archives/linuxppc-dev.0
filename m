Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE006.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 4CD6ADE0C7
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 07:38:04 +1000 (EST)
Received: from mail101-wa4 (localhost.localdomain [127.0.0.1])	by
	mail101-wa4-R.bigfish.com (Postfix) with ESMTP id 615B8161860A	for
	<linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 21:38:01 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])	by mail101-wa4.bigfish.com
	(Postfix) with ESMTP id 96642158806D	for <linuxppc-dev@ozlabs.org>;
	Tue,  5 Aug 2008 21:37:59 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim
	4.63)	(envelope-from
	<John.Linn@xilinx.com>)	id 1KQUEA-0000uZ-Mh	for linuxppc-dev@ozlabs.org;
	Tue, 05 Aug 2008 14:37:58 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8F743.86F1045E"
Subject: Kconfig debug help
Date: Tue, 5 Aug 2008 15:37:56 -0600
From: John Linn <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <20080805213759.96642158806D@mail101-wa4.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8F743.86F1045E
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I'm trying to debug some Kconfig problems and am looking for a way to
get more debug output.

 =


I have used KBUILD_VERBOSE=3D1 on the command line and it didn't help
much.

 =


I'm seeing an issue with creating a new defconfig file for a board.  I
get the .config created, then copy it to a defconfig, and then it
doesn't do anything when I run make with the defconfig file.  =


 =


Thanks for any help,

John



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8F743.86F1045E
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">=


<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I&#8217;m trying to debug some Kconfig problems and am
looking for a way to get more debug output.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I have used KBUILD_VERBOSE=3D1 on the command line and i=
t didn&#8217;t
help much.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I&#8217;m seeing an issue with creating a new defconfig =
file
for a board.&nbsp; I get the .config created, then copy it to a defconfig, =
and then
it doesn&#8217;t do anything when I run make with the defconfig file. &nbsp=
;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Thanks for any help,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>John<o:p></o:p></span></font></p>

</div>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</body>

</html>


------_=_NextPart_001_01C8F743.86F1045E--
