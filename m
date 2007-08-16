Return-Path: <ssaravanan@mail2web.com>
Received: from xsmtp04.mail2web.com (xsmtp04.mail2web.com [168.144.250.226])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C155DDE40
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 22:03:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7DFFA.7EF5E24E"
Date: Thu, 16 Aug 2007 07:40:08 -0400
Message-ID: <F3D55679E1DCFF49A57570501B70475F070D83B5@CL5EXBE04.ad2.softcom.biz>
References: <8779714.1620021187264042248.JavaMail.nabble@isper.nabble.com>
From: "dnl" <ssaravanan@mail2web.com>
To: <afleming@freescale.com>
Subject: My Kernel hangs after images verification and no boot msgs on Console?
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C7DFFA.7EF5E24E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
Hi Andy,

I am using MPC8555CDS board, montavista kernel, and  uboot for board =
bringup...
when i am booting montavista kernel using uboot i didn't get any message =
on Console...

 1. i can view the booting messages by "Dumping the printk Log Buffer".=20
 2. i am passing the "bootargs=3Dconsole=3DttyS0,115200 root=3D/dev/ram0 =
rw"

How can i get boot messages on serial console?

Regards,
Saravanan.S


------_=_NextPart_001_01C7DFFA.7EF5E24E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>My Kernel hangs after images verification and no boot msgs on =
Console?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2><BR>
Hi Andy,<BR>
<BR>
I am using MPC8555CDS board, montavista kernel, and&nbsp; uboot for =
board bringup...<BR>
when i am booting montavista kernel using uboot i didn't get any message =
on Console...<BR>
<BR>
&nbsp;1. i can view the booting messages by &quot;Dumping the printk Log =
Buffer&quot;.<BR>
&nbsp;2. i am passing the &quot;bootargs=3Dconsole=3DttyS0,115200 =
root=3D/dev/ram0 rw&quot;<BR>
<BR>
How can i get boot messages on serial console?<BR>
<BR>
Regards,<BR>
Saravanan.S<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7DFFA.7EF5E24E--
