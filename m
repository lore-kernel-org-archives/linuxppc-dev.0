Date: Sat, 27 Jan 2001 02:23:46 +0000
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao
	 mode
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
Cc: Amit Chaudhary <amitc@brocade.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010127022341.24831DBA47@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> You might be able to use xmon as well - I've never tried hard enough to
> understand xmon.

under 2.4.x xmon isn't too difficult - it's saved my bacon a few times.

under 2.2.x it depends on what adb hardware you have (via-cuda didn't work -
but I hacked 2.2.17 to get it going - don't suppose it would be too
difficult to move that hack to 2.2.18).  I posted a patch for via-cuda &
xmon sometime last year (can drag 'em out if you like).

----
basic instructions:

go to arch/ppc/xmon and edit start.c to enable output to both bootx screen &
the console (and a serial port as well if you like).  It's kinda grape-shot
- but if there's any form of oops you will probably see it this way.

You have to do a little hack to get output on bootx screen & console
simultaneously.  I can post a patch if it's tricky.

----

I keep wondering if it's worth asking Paulus to consider making the
different xmon output options CONFIG_XXXX instead of a file edit.  It gets
tedious if you pull every other day.

hth,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
