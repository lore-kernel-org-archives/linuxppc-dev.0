Subject: graphic controller in SVGA mode
To: linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Thu, 14 Nov 2002 09:28:34 +0100
Message-ID: <OF68382382.DE55804D-ONC1256C71.002DF056@eng.eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I'm currently using an EPSON S1D13506 graphic controller connected to a
405GP to manage an LCD panel in SVGA mode (800x600) in 16 bit per pixel.
It appears that the EPSON chip is a bit tight to manage such a controller
and it takes me around 300 ms to redisplay a new screen.

Who is using another controller to manage an LCD panel with this
resolution? (my target price is under 25$)

Laurent


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
