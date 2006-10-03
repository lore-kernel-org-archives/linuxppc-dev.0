Return-Path: <JLamb@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 07C9167C65
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 09:55:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E745.AF02F4DE"
Subject: Problem with External/PCI interrupts in MPC85xx
Date: Tue, 3 Oct 2006 19:43:09 -0400
Message-ID: <3C02138692C13C4BB675FE7EA24095291C4BA3@bluefin.Soneticom.local>
From: "Jason Lamb" <JLamb@Soneticom.com>
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

------_=_NextPart_001_01C6E745.AF02F4DE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We are having trouble receiving some external interrupts on our MPC8541E
processor. Our board and kernel image are loosely based on the
MPC8540_ADS freescale design. Our embedded system is not used as a
plug-in card. We are using the MPC8541 as the host PCI controller.

The interrupt line in question is used as a PCI interrupt input. We have
already determined that the line is toggling (active low) and that the
open_pic is configured to recognize active low, level triggered
interrupts. However, the open_pic is also indicating that this interrupt
input is disabled.

We tried to update the "mpc85xx_ads_map_irq" table in
"mpc85xx_ads_common.c" to reflect our IDSEL -> PIRQx input but the
problem persists.

Where are the interrupts enabled/disabled in ppc linux? We are using the
2.4.27 kernel.


Best regards,
Jason

------_=_NextPart_001_01C6E745.AF02F4DE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.69">
<TITLE>Problem with External/PCI interrupts in MPC85xx</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">Hi,<BR>
<BR>
We are having trouble receiving some external interrupts on our MPC8541E =
processor. Our board and kernel image are loosely based on the =
MPC8540_ADS freescale design. Our embedded system is not used as a =
plug-in card. We are using the MPC8541 as the host PCI =
controller.</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">The interrupt line in question is =
used as a PCI interrupt input. We have already determined that the line =
is toggling (active low) and that the open_pic is configured to =
recognize active low, level triggered interrupts. However, the open_pic =
is also indicating that this interrupt input is disabled.<BR>
<BR>
We tried to update the &#8220;mpc85xx_ads_map_irq&#8221; table in =
&#8220;mpc85xx_ads_common.c&#8221; to reflect our IDSEL -&gt; PIRQx =
input but the problem persists.</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">Where are the interrupts =
enabled/disabled in ppc linux? We are using the 2.4.27 =
kernel.</SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">Best regards,</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">Jason</SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C6E745.AF02F4DE--
