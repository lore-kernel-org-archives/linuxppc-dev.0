Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 95710DDEC2
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 05:57:37 +1100 (EST)
Received: from sj-core-3.cisco.com (sj-core-3.cisco.com [171.68.223.137])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m1PIl56s006775
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 10:47:05 -0800
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com
	[128.107.191.100])
	by sj-core-3.cisco.com (8.12.10/8.12.6) with ESMTP id m1PIl5J9027352
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 18:47:05 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C877DE.D07A48C4"
Subject: What happened to cpm2_hostalloc
Date: Mon, 25 Feb 2008 10:47:04 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1AAEC@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C877DE.D07A48C4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
In Linux 2.6.11 version, there was a function named "cpm2_hostalloc"  to
allocate memory at
specific boundary. I am not able to locate that in the latest Linux
version, 2.6.24-rc4. Is there any
similiar function to this that I can use?=20
The SPI module on the CPM2 module required the memory descriptor on the
ram to be at specific
boundray (8 bytes).
=20
Many thanks in advance,
Bizhan

------_=_NextPart_001_01C877DE.D07A48C4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D765404118-25022008>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D765404118-25022008>In =
Linux 2.6.11=20
version,&nbsp;there was a function named "cpm2_hostalloc"&nbsp; to =
allocate=20
memory at</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D765404118-25022008>specific boundary. I=20
am not able to locate that in the latest Linux version, 2.6.24-rc4. Is =
there=20
any</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D765404118-25022008>similiar function to=20
this that I can use? </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D765404118-25022008>The =
SPI module on=20
the CPM2 module required the memory descriptor on the ram to be at=20
specific</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D765404118-25022008>boundray (8=20
bytes).</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D765404118-25022008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D765404118-25022008>Many =
thanks in=20
advance,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D765404118-25022008>Bizhan</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C877DE.D07A48C4--
