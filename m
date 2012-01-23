Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CE08B6F9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2012 18:49:21 +1100 (EST)
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
 by relay1.mentorg.com with esmtp
 id 1RpEeS-0004ye-Rj from Farrukh_Arshad@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Sun, 22 Jan 2012 23:49:16 -0800
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Searching TLB entry for a page frame number.
Date: Mon, 23 Jan 2012 07:49:14 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050CDFE1@EU-MBX-03.mgc.mentorg.com>
Content-Type: multipart/alternative;
 boundary="_000_93CD5F41FDBC6042A6B449764F3B35CC050CDFE1EUMBX03mgcmento_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CDFE1EUMBX03mgcmento_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Greetings All,

I have a quick question regarding TLB dump for P1022. Please excuse me for =
being na=EFve. I want to dump the TLB entry for a page number. I know my pa=
ge frame number. If I read TLB0 dump using tlbre instruction, the instructi=
on output TLB0 entries in MAS0 - MAS3 registers. After the tlbre instructio=
n the value of MAS3 register [32-51] RPN, Is this Real Page Number is the p=
age frame number for which I am searching the TLB entry.


Best Regards

Farrukh Arshad
Sr. Software Development Engineer
Mentor Graphics Pakistan
Ph:   +92 - 423 - 609 - 92 - 09
Cell: +92 - 303 - 444 - 77 - 05


--_000_93CD5F41FDBC6042A6B449764F3B35CC050CDFE1EUMBX03mgcmento_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Felix Titling";
	panose-1:4 6 5 5 6 2 2 2 10 4;}
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
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Greetings All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a quick question regarding TLB dump for P1022=
. Please excuse me for being na=EFve. I want to dump the TLB entry for a pa=
ge number. I know my page frame number. If I read TLB0 dump using tlbre ins=
truction, the instruction output TLB0
 entries in MAS0 &#8211; MAS3 registers. After the tlbre instruction the va=
lue of MAS3 register [32-51] RPN, Is this Real Page Number is the page fram=
e number for which I am searching the TLB entry.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Felix Titling&quot;;color:#943634">Farrukh</span></b><b><span style=3D"fon=
t-size:10.0pt;font-family:&quot;Felix Titling&quot;"> Arshad<o:p></o:p></sp=
an></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Sr. Software Development Engineer<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Mentor Graphics Pakistan<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Ph:&nbsp;&nbsp; &#43;92 &#8211; 423 &#8211; 609 &#8211; 92=
 - 09<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Cell: &#43;92 &#8211; 303 &#8211; 444 &#8211; 77 &#8211; 0=
5<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CDFE1EUMBX03mgcmento_--
