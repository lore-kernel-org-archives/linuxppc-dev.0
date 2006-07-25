Return-Path: <yogi.rajpal@infogain.com>
Received: from GDCMX01.igglobal.com (unknown [203.190.141.10])
	by ozlabs.org (Postfix) with ESMTP id 8CA1367B61
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 22:54:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6AFE7.E25C02A3"
Subject: implementing errata for ML403 board / PPC405F6 core
Date: Tue, 25 Jul 2006 18:09:42 +0530
Message-ID: <C86899CCB10A6C4E93D5978DCB232D4B01AE865A@GDCMX01.igglobal.com>
From: "Yogi Rajpal" <yogi.rajpal@infogain.com>
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

------_=_NextPart_001_01C6AFE7.E25C02A3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

I am following the errata at the following location and need to =
implement CPU_162, CPU_197 & CPU_212 for PPC405F6X1 core on Xilinx Ml403 =
board
 ( ftp://ftp.xilinx.com/pub/documentation/misc/ppc405f6v5_2_0.pdf )

Can anyone suggest the instructions needed to be implemented for these =
errata.

CPU_162 : When in Real Mode , the 405 core may errantly make speculative =
instruction fetches from guarded storage.

CPU_197 : Incorrect Real mode attributes may be used when accessing the =
last instruction in a 128 MB region.

CPU_212

thanks=20
yogi

------_=_NextPart_001_01C6AFE7.E25C02A3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>implementing errata for ML403 board / PPC405F6 core</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
I am following the errata at the following location and need to =
implement CPU_162, CPU_197 &amp; CPU_212 for PPC405F6X1 core on Xilinx =
Ml403 board<BR>
&nbsp;( <A =
HREF=3D"ftp://ftp.xilinx.com/pub/documentation/misc/ppc405f6v5_2_0.pdf">f=
tp://ftp.xilinx.com/pub/documentation/misc/ppc405f6v5_2_0.pdf</A> )<BR>
<BR>
Can anyone suggest the instructions needed to be implemented for these =
errata.<BR>
<BR>
CPU_162 : When in Real Mode , the 405 core may errantly make speculative =
instruction fetches from guarded storage.<BR>
<BR>
CPU_197 : Incorrect Real mode attributes may be used when accessing the =
last instruction in a 128 MB region.<BR>
<BR>
CPU_212<BR>
<BR>
thanks<BR>
yogi<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6AFE7.E25C02A3--
