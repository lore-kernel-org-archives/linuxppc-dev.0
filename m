Return-Path: <rini@arvoo.nl>
Received: from smtp3.euronet.nl (smtp3.euronet.nl [194.134.35.173])
	by ozlabs.org (Postfix) with ESMTP id 498AFDDE28
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Oct 2008 07:44:09 +1100 (EST)
Received: from arv-010 (mf-22dc1.mxs.adsl.euronet.nl [81.70.75.193])
	by smtp3.euronet.nl (Postfix) with ESMTP id 8D69039FE0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 21:13:59 +0100 (MET)
Received: from arv-010 (localhost [127.0.0.1])
	by arv-010 (Postfix) with ESMTP id 4DEE37154B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 21:13:59 +0100 (CET)
Received: from arv-002.arvoo.nl (unknown [192.168.0.2])
	by arv-010 (Postfix) with ESMTP id 96D687154B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 21:13:52 +0100 (CET)
Message-ID: <98283DE153354E85B4A428635DACF6AE@Rini1>
From: "Rini van Zetten" <rini@arvoo.nl>
To: <linuxppc-embedded@ozlabs.org>
Subject: Performance questions about SATA-ports MPC8377
Date: Wed, 29 Oct 2008 21:13:47 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0135_01C93A0B.3B633B20"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0135_01C93A0B.3B633B20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello List,

We do have some issues with the SATA ports on the Freescale MPC8377. The =
problem is that the read performance collapsed when both sata ports=20
are used simultaneously.

Reading from one disk gives about 90 - MB/sec
Reading from a raid-0 system gives about 80 MB sec. ( same test on a=20
intel computer gives 160 MB/sec)
Reading from two disks simultaneously gives about 40 MB/sec / disk

We use the linux 2.6.26-6 kernel.

questions :

1) Is this a known issue ?
2) Should the hardware be able to simultaneously read from both ports ?
3) Where can i find the latest linux driver available for the SATA port =
?
4) Do you have any tips to increase the performance on the SATA ports ?


Regards,

Rini van Zetten,
ARVOO Engineering B.V.
------=_NextPart_000_0135_01C93A0B.3B633B20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16735" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello List,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>We do have some issues with the SATA ports on the Freescale =
MPC8377. The=20
problem is that the read performance collapsed when both sata ports =
<BR>are used=20
simultaneously.<BR><BR>Reading from one disk gives about 90 - =
MB/sec<BR>Reading=20
from a raid-0 system gives about 80 MB sec. ( same test on a <BR>intel =
computer=20
gives 160 MB/sec)<BR>Reading from two disks simultaneously gives about =
40 MB/sec=20
/ disk<BR><BR>We use the linux 2.6.26-6 kernel.<BR><BR>questions =
:<BR><BR>1) Is=20
this a known issue ?<BR>2) Should the hardware be able to simultaneously =
read=20
from both ports ?<BR>3) Where can i find the latest linux driver =
available for=20
the SATA port ?<BR>4) Do you have any tips to increase the performance =
on the=20
SATA ports ?<BR><BR><BR>Regards,</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Rini van Zetten,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ARVOO Engineering =
B.V.</FONT></DIV></BODY></HTML>

------=_NextPart_000_0135_01C93A0B.3B633B20--
