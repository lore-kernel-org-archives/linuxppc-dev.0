Message-Id: <200007121316.OAA02671@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 14:16:43 +0100
Subject: Re: 2.4.0-t1 & t3: dmasound
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: schinder@pobox.com
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[snip]
> } Happy to try & fix - but it would be useful to know whether there are *any*
> } conditions under which it has worked.
>
> This is on a Performa 6400.
>
> linux% cat /dev/sndstat
> PowerMac (AWACS rev 2) DMA sound driver:
>  sound.format = 0x20 (signed 16 bit big)
>  sound.speed = 44100Hz (phys. 44100Hz)
>  sound.stereo = 0x1 (stereo)
>  sq.block_size = 32768 sq.max_count = 4 sq.max_active = 4
>  sq.count = 0 sq.rear_size = 12288
>  sq.active = 0 sq.syncing = 0
>
> linux% uname -a
> Linux c22234-c.scllg1.pa.home.com 2.4.0-test1-ac21 #1 Wed Jun 21 23:15:08
> EDT 2000 ppc unknown
>
> The source is from Paul's developent tree.
>
> I've compiled sound support in rather than as a module.  It works, but
> the only way to control the volume is by using the Gnome mixer.  On
> anything else I've tried (xmms, the CD player that comes with Gnome,
> reaplayer), the volume sliders don't work.  But the sound is fine.

thnx v. much - I've a hunch we're not getting any interrupts...
still investigating...

Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
