Date: Thu, 10 Dec 1998 15:42:48 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: framebuffer inconsistencies
Message-ID: <Pine.LNX.3.95.981210151530.9578B-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


there are some inconsistencies and recent problems with having multiple
video cards with recent kernels. some of the problems might actually be
driver problems in the ati xclaim vr driver. 

1. i used to be able to put consoles on both my monitors using
video=map:001 (i never tried the userland programs for setting up
consoles) however now, the fb1 screen only shows the blinking underline
cursor; no text appears although i can tell by the position of the cursor
that it is successfully running login on that console

2. the secondary monitor went spiralling into a bad video mode once when i
changed from console 3 to 6. it never recovered. 

3. fbset -s -fb /dev/fb1 doesn't really get the settings for the second
video/monitor. it returns the settings for fb0.

i've been digging in the kernel to see why (3) is happening.

fb0 is a control-driven nec xv17+
fb1 is a ati xclaimvr-driven apple 14" fixed-frequency monitor 

any pointers?

brad


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
