From: Juergen.Beisert@windriver.com
Message-ID: <83627E19A5D0C448BFAAF40873768B1F022C765A@lul-mail01.wrsec.fr>
To: tnt@246tnt.com, Stefano.Gaiotto@marconi.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: PCI scanning and devices initialization
Date: Wed, 18 Aug 2004 06:28:11 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> Yes, there may be something wrong with your hardware.

This could only be _one_ reason

> At the PCI init, PCI devices don't yet have an address, so the host
> detects them using configuration cycles. Theses uses a different
> addressing scheme, using each address line as a kind of "chip select".
> So the devices know the host is "talking" to it just by
> looking at it's
> IDSEL line going asserted. If on your board the IDSEL isn't wired
> properly then it won't work. Hopefully if that's the case,
> you can just
> wire it by hand, it's not a high speed signal.

Does the U-Boot PCI setup routine handles PCI devices behind a "PCI to
anything" bridge? Sometimes simple code ignores bridges. Don't know the
current U-Boot implementation. If not, there is no chance to access any
devices behind it (even if the hardware is correct).

JB

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
