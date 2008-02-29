Return-Path: <Phil.Hochstetler@serveron.com>
Received: from mail.serveron.com (mail.serveron.com [198.107.14.70])
	by ozlabs.org (Postfix) with ESMTP id 0DE76DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 04:36:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87AF7.FD4E6CAC"
Subject: ML403 Linux port questions
Date: Fri, 29 Feb 2008 09:24:46 -0800
Message-ID: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
From: "Phil Hochstetler" <Phil.Hochstetler@serveron.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C87AF7.FD4E6CAC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm setting up a new development environment to get a working port of
Linux on the Xilinx Virtex-4 chip  (I have a Xilinx ML403 board).  I'm
looking for the quickest way to get a working development environment
for the 2.6 kernel without paying thousands of $$ (what happened to
MontaVista?).  My first attempt was to use google and found lots of
resources.  The problem is that much of the info is dated or makes
assumptions about your environment.  I read Grants write-up at
http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex.  Because I
want to use Windows XP SP2 as the host if possible, I went down the path
of installing the current Cygwin and was able to create cross tools (gcc
4.1) successfully.  The problem I am having is that the Linux build
process requires a newer gcc than 3.4.4-3 which is what Cygwin provides.
I have used the EDK to build a bsp package successfully so that is not a
problem.  I tried to compile the 2.6.24.2 mainline kernel but it fails
to compile using the Cygwin tools (it never gets as far as using them).

=20

I guess what I am looking for is advise on the lowest risk, easiest to
set up environment to setup that will just work.  Also advise on which
kernel to use.   I don't need a detailed tutorial but a high level
direct that is known to work.  I am thinking of using either the secret
lab tree or the Xilinx tree as recommended in Grants wiki page.  Should
I just forget using XP and install a Linux (x86 processor so I must use
cross tools)?   If so, what is the recommend distro and what version?

=20

Thanks for all your sharing of experience.  I hope to contribute back as
soon as I can.

=20

--phil


------_=_NextPart_001_01C87AF7.FD4E6CAC
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

<p class=3DMsoNormal>I&#8217;m setting up a new development environment =
to get a
working port of Linux on the Xilinx Virtex-4 chip&nbsp; (I have a Xilinx =
ML403
board).&nbsp; I&#8217;m looking for the quickest way to get a working
development environment for the 2.6 kernel without paying thousands of =
$$ (what
happened to MontaVista?).&nbsp; My first attempt was to use google and =
found
lots of resources.&nbsp; The problem is that much of the info is dated =
or makes
assumptions about your environment.&nbsp; I read Grants write-up at <a
href=3D"http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex">http:/=
/wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex</a>.&nbsp;
Because I want to use Windows XP SP2 as the host if possible, I went =
down the
path of installing the current Cygwin and was able to create cross tools =
(gcc
4.1) successfully.&nbsp; The problem I am having is that the Linux build
process requires a newer gcc than 3.4.4-3 which is what Cygwin =
provides.&nbsp;
I have used the EDK to build a bsp package successfully so that is not a
problem.&nbsp; I tried to compile the 2.6.24.2 mainline kernel but it =
fails to
compile using the Cygwin tools (it never gets as far as using =
them).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I guess what I am looking for is advise on the =
lowest risk,
easiest to set up environment to setup that will just work.&nbsp; Also =
advise
on which kernel to use.&nbsp;&nbsp; I don&#8217;t need a detailed =
tutorial but
a high level direct that is known to work.&nbsp; I am thinking of using =
either
the secret lab tree or the Xilinx tree as recommended in Grants wiki
page.&nbsp; Should I just forget using XP and install a Linux (x86 =
processor so
I must use cross tools)?&nbsp;&nbsp; If so, what is the recommend distro =
and
what version?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks for all your sharing of experience.&nbsp; I =
hope to
contribute back as soon as I can.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>--phil<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C87AF7.FD4E6CAC--
