Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id BD15C67AA9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 18:33:35 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id 22C323C4C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 08:33:32 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 8 Feb 2005 08:33:31 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B6E@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: AW: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-bounces@ozlabs.org wrote on :
> > This will not work. Microwindows can only  use  a  plain framebuffer
> > interface,  but  the Coral-P does not allow for such a driver
> > because of the fact that it has a little-endian register interface.
>=20
> Or is it because 5200 swaps bytes around on PCI.  It sure looks to me
> like Freescale has made a major screwup in their implementation of
> PCI on the 5200.  I'd love for somebody to prove me wrong about this,
> but I'm afraid I'm right.  I was under the impression that
> CoralP worked
> nicely on 5200, but now I see that it also requires software
> tweaks to work
> on 5200.

I have similar problems with an MPC5200 board and a Silicon Motion
SM501 (Voyager) grafic controller. The controller has a PCI and a
local bus interface. We use the local bus interface to connect it
with the 5200. In 32 bit truecolor mode everything works fine, but
in 16 bit mode bytes are swapped: 0x12345678 =3D> 0x34127856.
I'm not sure, if this problem has something to do with the CoralP
problem, but it is likely too similar to be completely independent.
Does anyone use an SM501 in 16 bit mode?

regards,
Martin Krause
