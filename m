Return-Path: <s.deepak@gdatech.co.in>
Received: from mail.gdatech.co.in (unknown [220.225.128.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.gdatech.co.in",
	Issuer "mail.gdatech.co.in" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 93B2C67A74
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jan 2005 17:19:23 +1100 (EST)
Content-Type: multipart/mixed; boundary="=-bd-boundary-axc784brfdDAw4va"
Mime-Version: 1.0
Message-ID: <015801c4ff80$68185b60$4000a8c0@DeepakS>
From: "s.deepak" <s.deepak@gdatech.co.in>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 21 Jan 2005 11:44:03 +0530
Subject: USB Host Controller driver for ISP1362  
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format,
containing the original message body
and a footer added by BitDefender

--=-bd-boundary-axc784brfdDAw4va
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0155_01C4FFAE.81ACE2C0"

This is a multi-part message in MIME format.

------=_NextPart_000_0155_01C4FFAE.81ACE2C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Anyone had worked on porting non PCI ISP 1362 host controller drivers to =
PPC processor?

    We are using Philips ISP 1362 USB controller chip with ppc_405 =
processor in Non PCI platform.We are working on porting the standard =
ISP1362 host controller phci driver to our board on linux kernel 2.4.18. =

    We have made architecture specific changes to the hal driver =
provided by Philips and using the phci driver as if.

    The host controller driver fails to assign the device address to the =
device and the RootHubStatusChange interrupt of ISP1362  seems to be =
always asserted.


Please provide me with some suggestions on this.

With Regards,
Deepak S
------=_NextPart_000_0155_01C4FFAE.81ACE2C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1479" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Anyone had worked on&nbsp;porting =
non&nbsp;PCI ISP=20
1362 host controller drivers to PPC processor?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; We are using Philips =
ISP 1362=20
USB controller chip with ppc_405 processor in Non PCI platform.We are =
working on=20
porting the standard ISP1362 host controller phci driver to our board on =
linux=20
kernel 2.4.18. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; We have made =
architecture=20
specific changes to the hal driver provided by Philips and using the =
phci driver=20
as if.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; The host controller =
driver fails=20
to assign the device address to the device and the RootHubStatusChange =
interrupt=20
of ISP1362&nbsp; seems to be always asserted.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please provide me with some suggestions =
on=20
this.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>With Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Deepak S</FONT></DIV></BODY></HTML>

------=_NextPart_000_0155_01C4FFAE.81ACE2C0--

--=-bd-boundary-axc784brfdDAw4va
Content-Type: text/plain; name="BitDefender.txt"
Content-Disposition: inline; filename="BitDefender.txt"


-- 
This message contains information from GDA Technologies Inc  and affiliates, and is intended for the sole use of the individual and entity to whom it is addressed. It may contain information, including any attachments, that is privileged, confidential and exempt from disclosure under applicable law. If you are not the intended addressee, nor authorized to receive for the intended addressee, you are hereby notified that you may not use, copy, disclose or distribute to anyone the message or any information contained in the message. If you have received this electronic transmission in error, please notify the sender immediately by a "reply to sender only" message and destroy all electronic and hard copies of the communication, including attachments.
This message was scanned for spam and viruses by BitDefender.
For more information please visit http://linux.bitdefender.com/

--=-bd-boundary-axc784brfdDAw4va--
