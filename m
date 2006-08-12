Return-Path: <Rajan.Rai@ingenient.com>
Received: from mail.ingenient.com (unknown [63.87.52.245])
	by ozlabs.org (Postfix) with ESMTP id F285F679FB
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Aug 2006 02:09:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BE29.5D790361"
Subject: RE: PCI driver on EB8347
Date: Sat, 12 Aug 2006 11:07:09 -0500
Message-ID: <4DA89577C33E194ABEBC978921E858541B8E3E@exchange.ingenient.net>
References: <995B09A8299C2C44B59866F6391D2635018CA7@zch01exm21.fsl.freescale.net>
	<4DA89577C33E194ABEBC978921E858541B8E3B@exchange.ingenient.net>
	<94857DB0-ABC7-4AA5-BE5B-1CBEAA09D906@kernel.crashing.org>
	<44DDCAB8.80106@ingenient.com>
	<D9682BD5-FBDF-4D6C-BC82-6EF375DB6F46@kernel.crashing.org>
From: "rajan rai" <Rajan.Rai@ingenient.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: "Gala Kumar K.-galak" <kumar.gala@freescale.com>,
	Liu Dave-r63238 <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6BE29.5D790361
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Kumar,

         Here is lspci -v from my P2P system. In case you have any =
suggestion do let me know. I appreciate your help

00:11.0 PCI bridge: Texas Instruments PCI2050 PCI-to-PCI Bridge (rev 02) =
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D0
        I/O behind bridge: 0000f000-0000ffff
        Memory behind bridge: 9e000000-9fffffff
        Prefetchable memory behind bridge: =
000000009df00000-000000009df00000
        Capabilities: [dc] Power Management version 2

01:01.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 18
        Memory at 9fc00000 (32-bit, prefetchable) [size=3D4M]
        Memory at 9f000000 (32-bit, non-prefetchable) [size=3D8M]
        I/O ports at 3ffffff0 [size=3D16]
        Capabilities: [40] Power Management version 2

01:02.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 19
        Memory at 9ec00000 (32-bit, prefetchable) [size=3D4M]
        Memory at 9e000000 (32-bit, non-prefetchable) [size=3D8M]
        I/O ports at 3fffffe0 [size=3D16]
        Capabilities: [40] Power Management version 2


Regards
-Rajan Rai


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: Sat 8/12/2006 8:54 AM
To: rajan rai
Cc: Liu Dave-r63238; Gala Kumar K.-galak; linuxppc-embedded@ozlabs.org
Subject: Re: PCI driver on EB8347
=20

On Aug 12, 2006, at 7:34 AM, Rajan Rai wrote:

>
>
>          Thanks IRQ problem is resolved. As  pointed out it was =20
> problem with IRQ IDSEL mapping. Mapping needs to be different on =20
> Eval board I'm using and our custom design. But my driver is still =20
> not working on our custom design. PCI device doesn't receive any =20
> messages from MPC8347 on our custom design mother board which uses =20
> pci-bridge where as it works fine on Eval board which doesn't use =20
> PCI bridge.
>
>                         I guess problem lies at the kernel level =20
> and not the driver. Any tips apart from IDSEL IRQ settings at =20
> kernel level what else I need to change when I move from 1 mother =20
> board to another.  My PCI  devices do get base address 0 and 1 =20
> allocated properly by the OS. But when I try to write any messages =20
> on those addresses PCI device doesn't see them

Is the bridge getting configured correctly?  An lspci output would be =20
helpful from your system with the P2P bridge.

- kumar



------_=_NextPart_001_01C6BE29.5D790361
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: PCI driver on EB8347</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Kumar,<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Here is lspci -v from =
my P2P system. In case you have any suggestion do let me know. I =
appreciate your help<BR>
<BR>
00:11.0 PCI bridge: Texas Instruments PCI2050 PCI-to-PCI Bridge (rev 02) =
(prog-if 00 [Normal decode])<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, 66Mhz, =
medium devsel, latency 0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus: primary=3D00, =
secondary=3D01, subordinate=3D01, sec-latency=3D0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O behind bridge: =
0000f000-0000ffff<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory behind bridge: =
9e000000-9fffffff<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prefetchable memory behind =
bridge: 000000009df00000-000000009df00000<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [dc] Power =
Management version 2<BR>
<BR>
01:01.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, 66Mhz, =
medium devsel, latency 128, IRQ 18<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9fc00000 (32-bit, =
prefetchable) [size=3D4M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9f000000 (32-bit, =
non-prefetchable) [size=3D8M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 3ffffff0 =
[size=3D16]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [40] Power =
Management version 2<BR>
<BR>
01:02.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, 66Mhz, =
medium devsel, latency 128, IRQ 19<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9ec00000 (32-bit, =
prefetchable) [size=3D4M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9e000000 (32-bit, =
non-prefetchable) [size=3D8M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 3fffffe0 =
[size=3D16]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [40] Power =
Management version 2<BR>
<BR>
<BR>
Regards<BR>
-Rajan Rai<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Kumar Gala [<A =
HREF=3D"mailto:galak@kernel.crashing.org">mailto:galak@kernel.crashing.or=
g</A>]<BR>
Sent: Sat 8/12/2006 8:54 AM<BR>
To: rajan rai<BR>
Cc: Liu Dave-r63238; Gala Kumar K.-galak; =
linuxppc-embedded@ozlabs.org<BR>
Subject: Re: PCI driver on EB8347<BR>
<BR>
<BR>
On Aug 12, 2006, at 7:34 AM, Rajan Rai wrote:<BR>
<BR>
&gt;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks IRQ =
problem is resolved. As&nbsp; pointed out it was&nbsp;<BR>
&gt; problem with IRQ IDSEL mapping. Mapping needs to be different =
on&nbsp;<BR>
&gt; Eval board I'm using and our custom design. But my driver is =
still&nbsp;<BR>
&gt; not working on our custom design. PCI device doesn't receive =
any&nbsp;<BR>
&gt; messages from MPC8347 on our custom design mother board which =
uses&nbsp;<BR>
&gt; pci-bridge where as it works fine on Eval board which doesn't =
use&nbsp;<BR>
&gt; PCI bridge.<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; I guess problem lies at the kernel level&nbsp;<BR>
&gt; and not the driver. Any tips apart from IDSEL IRQ settings =
at&nbsp;<BR>
&gt; kernel level what else I need to change when I move from 1 =
mother&nbsp;<BR>
&gt; board to another.&nbsp; My PCI&nbsp; devices do get base address 0 =
and 1&nbsp;<BR>
&gt; allocated properly by the OS. But when I try to write any =
messages&nbsp;<BR>
&gt; on those addresses PCI device doesn't see them<BR>
<BR>
Is the bridge getting configured correctly?&nbsp; An lspci output would =
be&nbsp;<BR>
helpful from your system with the P2P bridge.<BR>
<BR>
- kumar<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6BE29.5D790361--
