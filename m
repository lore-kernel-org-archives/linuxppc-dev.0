From: phandel@cise.ufl.edu
Date: Fri, 10 Nov 2000 14:45:52 -0800 (PST)
Subject: Re: AWACS sound support with 2.4.0-test10 from linuxcare.com
In-reply-to: <Pine.LNX.4.30.0011092241110.17067-100000@andromeda.dsdk12.net>
To: Derrik Pates <dpates@andromeda.dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.21.0011101416180.16992-100000@like.mine.nu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Nov 2000, Derrik Pates wrote:

> The AWACS support does noto work - if built in, it'll pick up an IRQ, and
> play about a half-second of sound if you try to use mpg123 with it. If I
> try to load it as a module, the init fails, then less thank 30 seconds
> after, it dies to a boot monitor. Is there a fix for this anywhere? I'l
> like to be able to use sound with this machine.
> (This is on a Blue and white G3/250 tower.)

(3) like 2:21pm ~> cat /dev/sndstat  (on my PowerCenter Pro 210)
PowerMac (AWACS rev 2) DMA sound driver:
        sound.format = 0x20 (signed 16 bit big)
        sound.speed = 8000Hz (phys. 8820Hz)
        sound.stereo = 0x0 (mono)
        sq.block_size = 2048 sq.max_count = 4 sq.max_active = 4
        sq.count = 0 sq.rear_size = 520
        sq.active = 0 sq.syncing = 0

When I use esound in 2.4, "esdrec > foo" will cause sound to stop playing
after a few seconds, always creating a file which has exactly 16054 bytes
(I believe this is the correct number - I'll verify that tonight).

esdrec works fine when using a 2.2.x kernel.  I'm using esound 0.2.20.

Also, would someone know how to do the equivalent of "cat /dev/audio |
lame" without this esound & esdrec mess?


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
