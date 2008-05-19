Return-Path: <kernelppc@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 975B7DDF11
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 01:16:03 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1682436fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 May 2008 08:16:01 -0700 (PDT)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Instruction OCM
Date: Mon, 19 May 2008 17:17:29 +0200
Message-ID: <012401c8b9c3$74b947c0$5e2bd740$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0125_01C8B9D4.384217C0"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0125_01C8B9D4.384217C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear all,

I cannot run Linux when I have an instruction OCM in my design but, without
instruction OCM everything is fine. I tried to do some debugging. It seems
that the Linux memory management unit has a problem with that.  After
entering the MMU initialization phase, it suddenly jumps to address
0x00000700 it get stuck there. Is there anybody who have tried a design with
instruction OCM? Do I need to do special configuration for the Linux kernel?


Regards,

Mojtaba


------=_NextPart_000_0125_01C8B9D4.384217C0
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
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

<div class=3DSection1>

<p class=3DMsoNormal>Dear all,<o:p></o:p></p>

<p class=3DMsoNormal>I cannot run Linux when I have an instruction OCM =
in my design
but, without instruction OCM everything is fine. I tried to do some =
debugging.
It seems that the Linux memory management unit has a problem with that. =
&nbsp;After
entering the MMU initialization phase, it suddenly jumps to address =
0x00000700
it get stuck there. Is there anybody who have tried a design with =
instruction
OCM? Do I need to do special configuration for the Linux kernel? =
<o:p></o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal>Mojtaba<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0125_01C8B9D4.384217C0--
