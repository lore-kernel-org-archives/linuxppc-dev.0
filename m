Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id AF5EFDDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Mar 2007 21:14:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C771F3.6E66D718"
Subject: libgcc_s.so needed when compiling with eldk4.1.0 and not with
	edlk3.1.1
Date: Thu, 29 Mar 2007 13:14:34 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E71CD4C@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

------_=_NextPart_001_01C771F3.6E66D718
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

When I used eldk3.1.1 from denx the applications I compiled didn't need
libgcc_s.so but now that I'm using eldk4.1.0, applications also require
libgcc_s.so. Is it normal?
=20
Bye,
Antonio.

------_=_NextPart_001_01C771F3.6E66D718
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D019351211-29032007>When I =
used=20
eldk3.1.1 from denx the applications I compiled didn't need libgcc_s.so =
but now=20
that I'm using eldk4.1.0, applications also require libgcc_s.so. Is it=20
normal?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D019351211-29032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D019351211-29032007>Bye,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D019351211-29032007>Antonio.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C771F3.6E66D718--
