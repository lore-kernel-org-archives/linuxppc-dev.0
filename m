Return-Path: <rober.hsu@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id 741D767ED5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 22:25:09 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i1so208627nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Aug 2005 05:25:08 -0700 (PDT)
Message-ID: <001401c598ee$f59b20f0$0e01000a@orange>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 4 Aug 2005 20:20:49 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0011_01C59932.0148F420"
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

------=_NextPart_000_0011_01C59932.0148F420
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hello all,

     I'm porting Linux 2.4.25 at my MPC852T.I can make uImag and =
ramdisk.tar.gz  now.
My question is how to combine these two file to linux.bin  let linux =
auto mount ramdisk.image.gz.
I think one file would be easy to maintain and download.

PS:I used 2.4.25 and u-boot 1.1.3.I want linux.bin =3D =
uImage+ramdisk.image.gz and let u-boot autorun linux.bin=20
      at board start up.=20


Best Regards,
Rober Hsu
------=_NextPart_000_0011_01C59932.0148F420
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
MPC852T.I can make uImag and&nbsp;ramdisk.tar.gz&nbsp; now.</FONT></DIV>
<DIV><FONT size=3D2>My question is how to combine these two file to=20
linux.bin&nbsp; let linux auto mount ramdisk.image.gz.</FONT></DIV>
<DIV><FONT size=3D2>I think one file would&nbsp;be easy to maintain and=20
download.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>PS:I used 2.4.25 and u-boot 1.1.3.I want linux.bin =
=3D=20
uImage+ramdisk.image.gz and let u-boot autorun linux.bin </FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at board start up.=20
</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Best Regards,</FONT></DIV>
<DIV><FONT size=3D2>Rober Hsu</FONT></DIV></BODY></HTML>

------=_NextPart_000_0011_01C59932.0148F420--
