Subject: 8260 FCC buffer underrun
From: Jeff Angielski <jangiels@speakeasy.net>
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1092745466.4190.14.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 17 Aug 2004 08:24:26 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anybody know what conditions would cause the FCC to report a buffer
underrun transmit error when we are transmitting small ethernet
packets?  Especially since the packets are so small they only use 1
buffer descriptor.

The wierd thing is that ARP packets gets transmitted fine.  Anything
larger than that, however, generate the underrun errors.

The receive side appears to work fine.  Pings come in, get processed,
and then we attempt to transmit the reply.

This is on an EP8260 H2, a couple weeks old u-boot cvs, and bk pull of
linuxppc-2.4.27.

The hardware works because PlanetCore with bk pull of linuxppc-2.4.27
works fine [although PlanetCore has it's own configuration issues...].


Jeff Angielski


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
