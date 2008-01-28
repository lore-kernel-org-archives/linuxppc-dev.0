Return-Path: <Dag.K.Rognlien@sintef.no>
Received: from smtpb.sintef.no (smtpb.sintef.no [129.241.253.24])
	by ozlabs.org (Postfix) with ESMTP id 8896DDDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 00:55:49 +1100 (EST)
Received: from sintefav1.sintef.no (sintefav1.sintef.no [129.241.253.14])
	by smtpb.sintef.no (Postfix) with ESMTP id CCC5572279
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 14:28:43 +0100 (CET)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C861B1.B69366EA"
Subject: request_irq() for external interrupt pin on MPC875 (A&M adder MPC
	875)
Date: Mon, 28 Jan 2008 14:28:48 +0100
Message-ID: <39417DF3286A66428FA558987839F44F03FC914F@SINTEFXCH01.sintef.no>
From: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C861B1.B69366EA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

With kernel 2.6.13 we used=20
=20
request_irq (use_irq, irq_handler, SA_INTERRUPT|SA_SHIRQ, DEVICE_NAME,
dev)
=20
where use_irq is 12 to use the external IRQ6 pin.
=20
We are now trying to get this driver to work with the 2.6.25 pull from
powerpc.git.
=20
request_irq (use_irq, irq_handler, IRQF_SHARED, DEVICE_NAME, dev);
=20
returns -ENOSYS on the newer kernel.
=20
Have the IRQ mappings for the external IRQX pins been moved in the later
kernels?
=20
-
Dag K. W. Rognlien
Research Scientist
SINTEF ICT Communication Systems

=20
=20

------_=_NextPart_001_01C861B1.B69366EA
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii=
">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>With=
 kernel 2.6.13=20
we used </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>reques=
t_irq=20
(use_irq, irq_handler, SA_INTERRUPT|SA_SHIRQ, DEVICE_NAME,=20
dev)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>where=
 use_irq is 12=20
to use the external IRQ6 pin.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>We are=
 now trying to=20
get this driver to work with the 2.6.25 pull from=20
powerpc.git.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>reques=
t_irq=20
(use_irq, irq_handler, IRQF_SHARED, DEVICE_NAME, dev);</SPAN></FONT></DI=
V>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>return=
s -ENOSYS on=20
the newer kernel.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>Have=
 the IRQ=20
mappings for the external IRQX pins been moved in the later=20
kernels?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008>-</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D583401913-28012008>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Dag K. W. Rognlien</FONT><=
/DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Research Scientist</FONT><=
/DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>SINTEF ICT Communication=20
Systems</FONT></DIV></DIV>
<DIV><BR></DIV></SPAN></FONT>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D583401913-28012008></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C861B1.B69366EA--
