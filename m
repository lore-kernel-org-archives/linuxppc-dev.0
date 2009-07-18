Return-Path: <aaronleefly@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EFC65B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 23:03:25 +1000 (EST)
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 0ADE7DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Jul 2009 23:03:24 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so434229wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Jul 2009 06:03:22 -0700 (PDT)
From: "Li Jun (Aaron)" <aaronleefly@gmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: how do linux active the ppc405 cache?
Date: Sat, 18 Jul 2009 20:55:31 +0800
Message-ID: <001701ca07a7$0ba86a80$22f93f80$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0018_01CA07EA.19CBAA80"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01CA07EA.19CBAA80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

I have a question about cache activation on the Xilinx Virtex4 ML403 board.

I know that PowerPC instruction and data caches have to be activated
manually with the command 

XCache_EnableICache(); 

XCache_EnableDCache();

It works well with the standalone application, but how about it in Linux
system?

 When porting a linux 2.6 on the board, how the  cache can be activated by
the OS?

Thanks 

 


------=_NextPart_000_0018_01CA07EA.19CBAA80
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
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

<p>Hi all,<o:p></o:p></p>

<p>I have a question about cache activation on the Xilinx Virtex4 ML403 =
board.<o:p></o:p></p>

<p>I know that PowerPC instruction and data caches have to be activated
manually&nbsp;with the command <o:p></o:p></p>

<p>XCache_EnableICache(); <o:p></o:p></p>

<p>XCache_EnableDCache();<o:p></o:p></p>

<p>It works well with the standalone application, but how about it in =
Linux
system?<o:p></o:p></p>

<p>&nbsp;When porting a linux 2.6 on the board, how the&nbsp; cache can =
be
activated by the OS?<o:p></o:p></p>

<p>Thanks <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0018_01CA07EA.19CBAA80--
