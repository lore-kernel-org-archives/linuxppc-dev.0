Return-Path: <yuansshi@cisco.com>
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "rcdn-iport-9.cisco.com", Issuer "Cisco SSCA2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 01250B6F76
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 09:09:34 +1000 (EST)
Received: from xbh-rcd-201.cisco.com (xbh-rcd-201.cisco.com [72.163.62.200])
	by rcdn-core2-3.cisco.com (8.14.3/8.14.3) with ESMTP id p67Mx1HG021394
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jul 2011 22:59:01 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC3CF9.5A6D4897"
Subject: powerpc endian issue
Date: Thu, 7 Jul 2011 17:58:12 -0500
Message-ID: <903B27578F14C84C9E21318C226D89B455AC31@XMB-RCD-305.cisco.com>
From: "Yuan Shi (yuansshi)" <yuansshi@cisco.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC3CF9.5A6D4897
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am using perf to collect data from powerpc and analyze the data on a
local server.=20

When I am trying to use "perf report" the error "fatal:imcompatible file
format" comes up. It is noticed that the error is generated due to
perf_header size dismatch.

The issue is caused by that the powerpc is big endian and local server
is little endian.=20

I am wondering if any of you have ideas how to solve this problem.
Basically, how to analyze the perf.data generated on a powerpc on a
little endian Machine.

=20

=20

Sincerely yours,

Yuan


------_=_NextPart_001_01CC3CF9.5A6D4897
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hello,<o:p></o:p></p><p class=3DMsoNormal>I am using =
perf to collect data from powerpc and analyze the data on a local =
server. <o:p></o:p></p><p class=3DMsoNormal>When I am trying to use =
&#8220;perf report&#8221; the error &#8220;fatal:imcompatible file =
format&#8221; comes up. It is noticed that the error is generated due to =
perf_header size dismatch.<o:p></o:p></p><p class=3DMsoNormal>The issue =
is caused by that the powerpc is big endian and local server is little =
endian. <o:p></o:p></p><p class=3DMsoNormal>I am wondering if any of you =
have ideas how to solve this problem. Basically, how to analyze the =
perf.data generated on a powerpc on a little endian =
Machine.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Sincerely =
yours,<o:p></o:p></p><p =
class=3DMsoNormal>Yuan<o:p></o:p></p></div></body></html>
------_=_NextPart_001_01CC3CF9.5A6D4897--
