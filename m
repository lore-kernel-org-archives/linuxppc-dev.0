Subject: How to change endian attribute for a memory region
To: linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 15 Oct 2002 10:42:17 +0200
Message-ID: <OFA0841909.55B0BFCD-ONC1256C53.002F2136@eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I'm trying to interface a 405GP chip with an EPSON S1D13506 graphic
controller. Because the EPSON chip is a little endian, I need to have my
framebuffer memory acceded in little endian mode.
What is the best way to change endian attribute for a specific memory
region (ioremap little endian)?

Laurent


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
