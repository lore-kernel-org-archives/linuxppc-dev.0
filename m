To: linuxppc-embedded@lists.linuxppc.org
Subject: framebuffer access in little endian mode
MIME-Version: 1.0
Message-ID: <OFE7EE0F3B.3DB23516-ONC1256D4B.0023C9C9-C1256D4B.0026ED64@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Fri, 20 Jun 2003 08:48:15 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm designing a custom board with a 405GPr and a Silicon Motion SMI712
graphic controller. The interface to this chip is via PCI interface and it
gives access to its internal framebuffer in little endian format. Because
access done by the 405GPr are in big endian, color in 16bpp mode aren't
displayed correctly.

Unfortunately, it seems that the chip doesn't provide a way to access the
framebuffer in big endian format.

Any  hints are welcome.

Laurent

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
