Return-Path: <chris.wyse@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 21CB667B23
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 13:02:46 +1100 (EST)
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.3/8.13.3) with ESMTP id k26LZARR007151
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Mar 2006 13:35:10 -0800 (PST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C64165.D85A20E8"
Subject: Calling PCI Autoconfig again
Date: Mon, 6 Mar 2006 13:34:57 -0800
Message-ID: <927594BA71733F4BAA815162B79A3F513B27FD@ala-mail04.corp.ad.wrs.com>
From: "Wyse, Chris" <chris.wyse@windriver.com>
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

------_=_NextPart_001_01C64165.D85A20E8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I'm working on a board (PPC440GX CPU) that has an FPGA on it.  The FPGA
software has a PCI interface.  If I load the FPGA, then boot the Linux
kernel, the FPGA is recognized as a device on the PCI bus.  However, I'd
like to load the FPGA after the kernel has booted, then run autoconfig
again to detect the device.  What's the best way to do this? =20
=20
Please send responses directly to me (in addition to the list), since I
am not subscribed to the list.

Chris Wyse
Member of Technical Staff
Embedded Technologies
860-749-1556 office
860-978-0849 cell
413-778-9101 fax
http://www.windriver.com <http://www.windriver.com/>=20
 =20

=20

------_=_NextPart_001_01C64165.D85A20E8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><SPAN class=3D108245020-01032006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D108245020-01032006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D108245020-01032006><FONT face=3DArial><FONT =
size=3D2>I'm working on=20
a board (PPC440GX CPU) that has an FPGA on it.&nbsp; The FPGA software =
has a PCI=20
interface.&nbsp; If I load the FPGA, then boot the Linux kernel, the =
FPGA is=20
recognized as a device on the PCI bus.&nbsp; However, I'd like to load =
the FPGA=20
after the kernel has booted, then run autoconfig again to detect=20
the&nbsp;device.&nbsp; What's the best way to do this?<SPAN=20
class=3D155323221-06032006>&nbsp; </SPAN></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D108245020-01032006><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D155323221-06032006></SPAN></FONT></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D108245020-01032006><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D155323221-06032006>Please send responses directly to me (in =
addition to=20
the list), since I am not subscribed to the=20
list.</SPAN></FONT></FONT></SPAN></DIV></DIV>
<DIV align=3Dleft>
<P align=3Dleft><FONT size=3D2>Chris Wyse<BR>Member of&nbsp;Technical=20
Staff<BR>Embedded Technologies<BR>860-749-1556 office<BR>860-978-0849=20
cell<BR>413-778-9101 fax<BR><A title=3Dhttp://www.windriver.com/=20
href=3D"http://www.windriver.com/"=20
target=3D_blank>http://www.windriver.com</A><BR>&nbsp;</FONT> </P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C64165.D85A20E8--
