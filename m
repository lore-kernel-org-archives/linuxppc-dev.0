Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 361521007D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 20:42:45 +1100 (EST)
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
 by relay1.mentorg.com with esmtp
 id 1Ri0tG-0006RL-MQ from Farrukh_Arshad@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Tue, 03 Jan 2012 01:42:42 -0800
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: Problem in getting shared memory access on P1022RDK
Date: Tue, 3 Jan 2012 09:42:39 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050CCA80@EU-MBX-03.mgc.mentorg.com>
References: <93CD5F41FDBC6042A6B449764F3B35CC050CCA22@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050CCA22@EU-MBX-03.mgc.mentorg.com>
Content-Type: multipart/alternative;
 boundary="_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA80EUMBX03mgcmento_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA80EUMBX03mgcmento_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Adding more to it,

When I write from Core 1 on the shared memory region it is visible at Core =
0 and it can read what I have written from Core 1 but when I write from Cor=
e 0 on this shared memory it is not visible on Core 1.

Regards,
Farrukh Arshad

From: Arshad, Farrukh
Sent: Tuesday, January 03, 2012 12:11 AM
To: linuxppc-dev@lists.ozlabs.org
Subject: Problem in getting shared memory access on P1022RDK

Greetings All,

Please excuse me for a 'not very precise' question but I just need some clu=
e or point to look for the trouble.
I am running linux in AMP configuration on P1022RDK dual core. My memory pa=
rtitioning is given below

Core Base Address (CONFIG_PHYSICAL_START / bootm_low)
Size (bootm_size / mem kernel boot parameter)
Core 0 0x0000,0000
0x1000,0000
Core 1 0x1000,0000
0x0C00,0000
Shared Memory 0x1C00,0000
0x0400,0000

I have set bootm_low / bootm_size and provided mem parameter in both kernel=
 configurations, both
kernels are booting up fine. I have a shared memory driver running in both =
cores. My shared memory
driver just exposes the physical memory (0x1C00,0000) to user-space.

The problem I am facing is I can not get access to same shared memory in us=
er-space on both kernels.
I have verified my shared memory driver on another platform (p1022ds) and i=
t works perfect. I have also
tried using non-cached memory mapping in shared memory driver but that does=
 not work as well.

To me it seems one of my kernels is going beyond its defined memory partiti=
on (which I have set above), I have
set kernel's partitioning as CONFIG_PHYSICAL_START, bootm_size, bootm_low a=
nd mem kernel boot param.

Besides the shared memory driver, can anyone suggest or give me clue where =
should I look for the
trouble in the kernel.

Regards,
Farrukh Arshad.

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA80EUMBX03mgcmento_
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
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Felix Titling";
	panose-1:4 6 5 5 6 2 2 2 10 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.apple-tab-span
	{mso-style-name:apple-tab-span;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Adding more to it,<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">When I write from Core 1 =
on the shared memory region it is visible at Core 0 and it can read what I =
have written from Core 1 but when I write from Core 0 on
 this shared memory it is not visible on Core 1. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Regards,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Fe=
lix Titling&quot;;color:#1F497D">Farrukh Arshad<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Arshad, =
Farrukh
<br>
<b>Sent:</b> Tuesday, January 03, 2012 12:11 AM<br>
<b>To:</b> linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> Problem in getting shared memory access on P1022RDK<o:p></o=
:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Greetings All,<o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Please excuse me for a 'not =
very precise' question but I just need some clue or point to look for the t=
rouble.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">I am running linux in AMP co=
nfiguration on P1022RDK dual core. My memory partitioning is given below<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Core<span class=3D"apple-tab=
-span">
</span>Base Address (CONFIG_PHYSICAL_START / bootm_low)<span class=3D"apple=
-tab-span"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Size (bootm_size / mem kerne=
l boot parameter)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Core 0<span class=3D"apple-t=
ab-span">
</span>0x0000,0000<span class=3D"apple-tab-span"><o:p></o:p></span></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">0x1000,0000<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Core 1<span class=3D"apple-t=
ab-span">
</span>0x1000,0000<span class=3D"apple-tab-span"><o:p></o:p></span></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">0x0C00,0000<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Shared Memory<span class=3D"=
apple-tab-span">
</span>0x1C00,0000<span class=3D"apple-tab-span"><o:p></o:p></span></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">0x0400,0000<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">I have set bootm_low / bootm=
_size and provided mem parameter in both kernel configurations, both&nbsp;<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">kernels are booting up fine.=
 I have a shared memory driver running in both cores. My shared memory&nbsp=
;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">driver just exposes the phys=
ical memory (0x1C00,0000) to user-space.&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">The problem I am facing is I=
 can not get access to same shared memory in user-space on both kernels.<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">I have verified my shared me=
mory driver on another platform (p1022ds) and it works perfect. I have also=
&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">tried using non-cached memor=
y mapping in shared memory driver but that does not work as well.&nbsp;<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">To me it seems one of my ker=
nels is going beyond its defined memory partition (which I have set above),=
 I have&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">set kernel's partitioning as=
 CONFIG_PHYSICAL_START, bootm_size, bootm_low and mem kernel boot param.<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Besides the shared memory dr=
iver, can anyone suggest or give me clue where should I look for the&nbsp;<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">trouble in the kernel.<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Regards,<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">Farrukh Arshad.<o:p></o:p></=
span></p>
</div>
</div>
</div>
</body>
</html>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA80EUMBX03mgcmento_--
