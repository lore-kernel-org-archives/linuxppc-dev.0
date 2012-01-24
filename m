Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1FD1B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 23:37:42 +1100 (EST)
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
 by relay1.mentorg.com with esmtp
 id 1Rpfd2-00023H-M3 from Farrukh_Arshad@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Tue, 24 Jan 2012 04:37:36 -0800
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: LCD (connected over DVI) not working on P1022DS
Date: Tue, 24 Jan 2012 12:37:35 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050CE1C3@EU-MBX-03.mgc.mentorg.com>
Content-Type: multipart/alternative;
 boundary="_000_93CD5F41FDBC6042A6B449764F3B35CC050CE1C3EUMBX03mgcmento_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CE1C3EUMBX03mgcmento_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings All,

I am trying to connect LCD with P1022DS via DVI port, I have also configure=
d CONFIG_FB_FSL_DIU and using following boot parameters, but I can't see an=
ything on the LCD not even the Linux Logo (I have configured it as well in =
the kernel) instead I only see on the LCD "No Signal from the Source". My L=
CD is working on another board. The "Freescale DIU Driver" is also loading =
during boot, but I got the same message on LCD of "No Signal".

diufb=3D15M video=3Dfslfb:800x480M-32@72, monitor=3D0

Also tried fslfb:800x600
and monitor=3D1 and without monitor.

Any patch I am missing or anything else ?

Best Regards

Farrukh Arshad
Sr. Software Development Engineer
Mentor Graphics Pakistan
Ph:   +92 - 423 - 609 - 92 - 09
Cell: +92 - 303 - 444 - 77 - 05


--_000_93CD5F41FDBC6042A6B449764F3B35CC050CE1C3EUMBX03mgcmento_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
<p class=3D"MsoNormal">I am trying to connect LCD with P1022DS via DVI port=
, I have also configured CONFIG_FB_FSL_DIU and using following boot paramet=
ers, but I can&#8217;t see anything on the LCD not even the Linux Logo (I h=
ave configured it as well in the kernel)
 instead I only see on the LCD &#8220;No Signal from the Source&#8221;. My =
LCD is working on another board. The &#8220;Freescale DIU Driver&#8221; is =
also loading during boot, but I got the same message on LCD of &#8220;No Si=
gnal&#8221;. &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
diufb=3D15M video=3Dfslfb:800x480M-32@72, monitor=3D0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Also tried <span style=3D"font-family:&quot;Courier =
New&quot;">fslfb:800x600
<o:p></o:p></span></p>
<p class=3D"MsoNormal">and <span style=3D"font-family:&quot;Courier New&quo=
t;">monitor=3D1</span> and without monitor.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any patch I am missing or anything else ?<o:p></o:p>=
</p>
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

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CE1C3EUMBX03mgcmento_--
