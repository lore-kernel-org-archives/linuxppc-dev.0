Return-Path: <rober.hsu@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.197])
	by ozlabs.org (Postfix) with ESMTP id 0B54F67E3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 02:35:45 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so224829rne
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 Aug 2005 09:35:44 -0700 (PDT)
Message-ID: <002701c59848$cb6b6ed0$0e01000a@orange>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 4 Aug 2005 00:28:16 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0022_01C5988B.68455EE0"
From: =?big5?B?rn2z06vC?= <rober.hsu@gmail.com>
Subject: about linux 2.4.25 on MPC852T
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

------=_NextPart_000_0022_01C5988B.68455EE0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hello all,

     I'm porting Linux 2.4.25 at my MPC852T.My first used is 2.4.4, I =
assign my board info ptr to 0x3400 and pass it to linux 2.4.4.
It works fine. But 2.4.25's head.S changes much code  I don't know how =
to porting it. I need help.

My add code  like this

li    r3, 0x3400
mr r11,r3=20
(../arch/ppc/mbxboot/head.S)

to 2.4.4.

    Another question is where can i find older kernel like 2.4.10, =
2.4.12,2.4.18 for PowerPC?I know DENX Linux kernel source tree
has the latest version, but i'm not sure there has above version that I =
want and I don't how to used cvs command to get it.If anyone
know where to download older kernel, please tell me,thanks.

Best Regards,
Rober Hsu
------=_NextPart_000_0022_01C5988B.68455EE0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2900.2668" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>Hello all,</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; I'm porting Linux 2.4.25 at =
my=20
MPC852T.My first used is 2.4.4,&nbsp;I assign&nbsp;my board info ptr to =
0x3400=20
and pass it to linux 2.4.4.</FONT></DIV>
<DIV><FONT size=3D2>It works fine. But 2.4.25's head.S changes much code =
&nbsp;I=20
don't know how to porting it. I need help.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV>
<DIV><FONT size=3D2>My&nbsp;add&nbsp;code&nbsp; like this</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>li&nbsp;&nbsp;&nbsp; r3, 0x3400</FONT></DIV>
<DIV><FONT size=3D2>mr&nbsp;r11,r3 </FONT></DIV>
<DIV><FONT size=3D2>(../arch/ppc/mbxboot/head.S)</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>to 2.4.4.</FONT></DIV></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;<FONT size=3D2>&nbsp;&nbsp; Another question is where can i =
find older=20
kernel like 2.4.10, 2.4.12,2.4.18 for PowerPC?I know DENX Linux kernel =
source=20
tree</FONT></DIV>
<DIV><FONT size=3D2>has the latest version, but i'm not sure there has =
above=20
version that I want and I don't how to used cvs command to get it.If=20
anyone</FONT></DIV>
<DIV><FONT size=3D2>know where to download older kernel, please tell=20
me,thanks.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Best Regards,</FONT></DIV>
<DIV><FONT size=3D2>Rober Hsu</FONT></DIV></BODY></HTML>

------=_NextPart_000_0022_01C5988B.68455EE0--
