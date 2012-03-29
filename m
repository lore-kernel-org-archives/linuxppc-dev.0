Return-Path: <r66093@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B895B6F62
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2012 21:01:32 +1100 (EST)
Received: from mail49-am1 (localhost [127.0.0.1])	by mail49-am1-R.bigfish.com
 (Postfix) with ESMTP id 3D0A32C02E5	for <linuxppc-dev@ozlabs.org>;
 Thu, 29 Mar 2012 10:01:28 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.254])	by
 mail49-am1.bigfish.com (Postfix) with ESMTP id C508524004C	for
 <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2012 10:01:25 +0000 (UTC)
From: Huang Changming-R66093 <r66093@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: why use 'raw_spin_lock_irqsave'  inf function
 'of_find_node_with_property'
Date: Thu, 29 Mar 2012 10:01:22 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C05F5BA@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: multipart/alternative;
 boundary="_000_110EED8CC96DFC488B7E717A2027A27C05F5BA039SN1MPN1003039d_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_110EED8CC96DFC488B7E717A2027A27C05F5BA039SN1MPN1003039d_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, all
In function "of_find_node_with_property", why use "raw_spin_lock_irqsave" t=
o disable preemption and disable interrupt?
If enable them, what impact will be observed?
This function just finds the node from the DTS file, it can't be interrupte=
d or preempted?

I have done one test: remove "raw_spin_lock_irqsave" and "raw_spin_unlock_i=
rqrestore" from this function,
It seems there is no any bad result, the Linux kernel still work well.

Best Regards
Jerry Huang


--_000_110EED8CC96DFC488B7E717A2027A27C05F5BA039SN1MPN1003039d_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
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
	{font-family:SimSun;
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
	margin:1.0in 1.25in 1.0in 1.25in;}
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
<p class=3D"MsoNormal">Hi, all<o:p></o:p></p>
<p class=3D"MsoNormal">In function &#8220;of_find_node_with_property&#8221;=
, why use &#8220;raw_spin_lock_irqsave&#8221; to disable preemption and dis=
able interrupt?<o:p></o:p></p>
<p class=3D"MsoNormal">If enable them, what impact will be observed?<o:p></=
o:p></p>
<p class=3D"MsoNormal">This function just finds the node from the DTS file,=
 it can&#8217;t be interrupted or preempted?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have done one test: remove &#8220;raw_spin_lock_ir=
qsave&#8221; and &#8220;raw_spin_unlock_irqrestore&#8221; from this functio=
n,<o:p></o:p></p>
<p class=3D"MsoNormal">It seems there is no any bad result, the Linux kerne=
l still work well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Jerry Huang<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_110EED8CC96DFC488B7E717A2027A27C05F5BA039SN1MPN1003039d_--
