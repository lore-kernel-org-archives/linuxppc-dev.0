Message-ID: <3C163F3E.D33F1DE9@laposte.net>
Date: Tue, 11 Dec 2001 18:15:42 +0100
From: Phil <ibm405.linux@laposte.net>
MIME-Version: 1.0
To: list <linuxppc-embedded@lists.linuxppc.org>
Subject: Console on 16 bits bus
References: <20011211164223.5577410E12@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm currently trying to integrate the S1D13506 framebuffer driver into
my linux kernel for the 405GP evaluation board (walnut).The S1D13506
controller is directly connected to the external bus of the 405GP and
the data bus width is 16 bits wide.
The problem I have is that all the console accesses to the framebuffer
video ram (in console.c file) are made via 32 bits wide calls
(fb_writel).
How can I solve this problem?

Thanks,

Laurent MOHIN, Acterna

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
