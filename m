Date: Tue, 21 Mar 2000 00:23:48 -0800 (PST)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: aty128fb patch on iMac DV
Message-ID: <Pine.GSO.4.21.0003202326590.17973-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running linux-pmac-stable on my iMac 350. The aty128 framebuffer on
this machine has had similar problems to the new G4s, though it doesn't
have a Rage Pro card. Specifically, video appears in several frames and at
odd colors for any color depth above 8-bit. In 8-bit mode video appears
fine except that the entire screen is shifted down exactly one pixel,
about halfway across the screen.

The offb driver works fine on this machine, but will not switch to any
color depth other than 8.

I applied Kevin Hendricks' latest rage128.patch, and aty128fb now works
perfectly in 8-bit color. It still fails as before in 15/16, 24, and
32-bit modes. I get the following message when I do "fbset -depth 16":

fbcon_setup: No support for fontwidth 8
fbcon_setup: type 0 (aux 0, depth 16) not supported

So the patch was an improvement, but there are still problems. I don't
know anything about video drivers, but am willing to help test out any
changes, or muck around with the driver myself if someone will give me a
few pointers or a place to start.

Matt Brubeck


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
