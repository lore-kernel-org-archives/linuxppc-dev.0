Message-Id: <200003131630.KAA28738@lists.linuxppc.org>
Date: Mon, 13 Mar 2000 11:29:17 -0500 (EST)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: 1 line kernel patch and new Xpmac now works on new sawtooth G4s !
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

By changing the constants.xclk value to 0x36d5 in the stable kernel aty128fb.c
and running a slightly modified Xpmac that recognizes the Rage128Pro graphics
card (id 0x5046) I now have nicely working Rage 128 acceleration.

There is still a problem using just the OF frame buffer device in place of the
modified aty128fb video driver that I will look at later.

If anyone wants the aty128fb.c diff and/or a binary Xpmac.special (the source is
at at home but coming tomorrow!), just let me know and I will post them.

The XF 4.0 R128 driver still has yet to be fixed (the defaults used in place of
the rom bios probe matched the old aty128fb.c xclk value and not the new ones.

So no more split vertical panes under new G4 machines!

Hooray I can finally do something at over 8bpp!

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
