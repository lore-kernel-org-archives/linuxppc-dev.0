Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E6FCB71A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2011 17:18:27 +1100 (EST)
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
 by relay1.mentorg.com with esmtp
 id 1RdySV-0005C2-KQ from Farrukh_Arshad@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Thu, 22 Dec 2011 22:18:23 -0800
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: OpenPIC warnings on P1022RDK AMP configuration
Date: Fri, 23 Dec 2011 06:18:20 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050C9E2F@EU-MBX-03.mgc.mentorg.com>
Content-Type: multipart/alternative;
 boundary="_000_93CD5F41FDBC6042A6B449764F3B35CC050C9E2FEUMBX03mgcmento_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050C9E2FEUMBX03mgcmento_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings All

I am running dual linux on P1022RDK in AMP configuration. My memory partiti=
oning is as below

---------------------------------------------------------------------
Core                      | Base Address  |    Size                 |
--------------------------|---------------|-------------------------|
Core 0 (MEL RT Kernel)    | 0x0000,0000   | 0x0C00,0000 - 192 (MB)  |
Core 1 (LTIB Kernel)      |0x0C00,0000    | 0x1000,0000 - 256 (MB)  |
MCAPI - Shared Mem        | 0x1C00,0000   | 0x0400,0000 - 64  (MB)  |
---------------------------------------------------------------------

My kernel command lines are for both cores

setenv core0bootargs root=3D/dev/mmcblk0p3 rootdelay=3D5 rw mem=3D192M
setenv core1bootargs root=3D/dev/nfs nfsroot=3D<serverip>:/<rootfs> ip=3Ddh=
cp mem=3D256M

I have also partitioned my hardware among both cores and supplied appropria=
te "protected-sources" in mpic node of both DTS files. The problem is, I re=
ceive following warning continuously only on Core 0 console, but Core 1 is =
running smooth. In following warnings source irqs are mostly which I have a=
ssigned to Core 1, but they are present in Core 0 mpic node "protected-sour=
ces" list, then why I am getting these messages.

[    6.219204] __ratelimit: 5796 callbacks suppressed
[    6.223996]  OpenPIC  : Got protected source 30 !
[    7.005809]  OpenPIC  : Got protected source 30 !
[    8.005906]  OpenPIC  : Got protected source 30 !
[    8.433053]  OpenPIC  : Got protected source 29 !
[    8.437942]  OpenPIC  : Got protected source 30 !
[    8.443101]  OpenPIC  : Got protected source 30 !
[    8.448428]  OpenPIC  : Got protected source 30 !

Any thoughts ?

Best Regards

Farrukh Arshad
Sr. Software Development Engineer
Mentor Graphics Pakistan
Ph:   +92 - 423 - 609 - 92 - 09
Cell: +92 - 303 - 444 - 77 - 05


--_000_93CD5F41FDBC6042A6B449764F3B35CC050C9E2FEUMBX03mgcmento_
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
<p class=3D"MsoNormal">Greetings All<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am running dual linux on P1022RDK in AMP configura=
tion. My memory partitioning is as below<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
---------------------------------------------------------------------<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Core&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Base Address&nbsp; |&nbsp;&=
nbsp;&nbsp; Size &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
--------------------------|---------------|-------------------------|<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Core 0 (MEL RT Kernel)&nbsp;&nbsp;&nbsp; | 0x0000,0000&nbsp;&nbsp; | 0x0C00=
,0000 - 192 (MB)&nbsp;&nbsp;|<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Core 1 (LTIB Kernel) &nbsp;&nbsp;&nbsp;&nbsp; |0x0C00,0000&nbsp;&nbsp;&nbsp=
; | 0x1000,0000 - 256 (MB)&nbsp;&nbsp;|<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
MCAPI - Shared Mem&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; | 0x1C00,0000&nbsp;=
&nbsp; | 0x0400,0000 - 64&nbsp; (MB)&nbsp;&nbsp;|</span>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
---------------------------------------------------------------------<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My kernel command lines are for both cores <o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core0bootargs root=3D/dev/mmcblk0p3 rootdelay=3D5 rw mem=3D192M<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core1bootargs root=3D/dev/nfs nfsroot=3D&lt;serverip&gt;:/&lt;rootfs=
&gt; ip=3Ddhcp mem=3D256M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have also partitioned my hardware among both cores=
 and supplied appropriate &#8220;protected-sources&#8221; in mpic node of b=
oth DTS files. The problem is, I receive following warning continuously onl=
y on Core 0 console, but Core 1 is running smooth.
 In following warnings source irqs are mostly which I have assigned to Core=
 1, but they are present in Core 0 mpic node &#8220;protected-sources&#8221=
; list, then why I am getting these messages.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 6.219204] __ratelimit: 5796 callbacks suppressed<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 6.223996]&nbsp; OpenPIC&nbsp; : Got protected source 30=
 !<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 7.005809]&nbsp; OpenPIC&nbsp; : Got protected source 30=
 !<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.005906]&nbsp; OpenPIC&nbsp; : Got protected source 30=
 !<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.433053]&nbsp; OpenPIC&nbsp; : Got protected source 29=
 !<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.437942]&nbsp; OpenPIC&nbsp; : Got protected source 30=
 !<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.443101]&nbsp; OpenPIC&nbsp; : Got protected source 30=
 !<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.448428]&nbsp; OpenPIC&nbsp; : Got protected source 30=
 !<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Any thoughts ?<o:p></o:p></p>
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

--_000_93CD5F41FDBC6042A6B449764F3B35CC050C9E2FEUMBX03mgcmento_--
