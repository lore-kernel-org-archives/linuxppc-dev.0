Return-Path: <udayton13@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id 16BC167CC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 08:06:46 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1837971wxd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 13:06:44 -0800 (PST)
From: "Brett McNerney" <udayton13@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Multiple Ethernet Ports on Xilinx FPGA
Date: Mon, 20 Nov 2006 16:06:41 -0500
Message-ID: <004101c70ce7$c7bd5040$0402a8c0@lilmacsnote>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0042_01C70CBD.DEE74840"
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

------=_NextPart_000_0042_01C70CBD.DEE74840
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

I currently have a custom board that we have successfully booted Linux on
and gotten telnet and ftp over a single Ethernet port to work.  What I would
like to do now is have it boot and use both the Ethernet ports located on
the board.  I have looked at the adapter.c file but was unsure how to go
about making this work.  I have searched around online to see if I could get
an idea how to do this but have not had any success in finding an answer.
Any help would be greatly appreciated.  And oh ya by the way I am working
with the 2.4.26 kernel.

Thanks

Brett


------=_NextPart_000_0042_01C70CBD.DEE74840
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I currently have a custom board that we have =
successfully booted
Linux on and gotten telnet and ftp over a single Ethernet port to =
work.&nbsp; What I
would like to do now is have it boot and use both the Ethernet ports =
located on
the board.&nbsp; I have looked at the adapter.c file but was unsure how =
to go about making
this work.&nbsp; I have searched around online to see if I could get an =
idea how to
do this but have not had any success in finding an answer.&nbsp; Any =
help would be
greatly appreciated.&nbsp; And oh ya by the way I am working with the =
2.4.26 kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Brett<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0042_01C70CBD.DEE74840--
