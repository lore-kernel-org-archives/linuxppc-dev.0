Message-Id: <200008021950.UAA23533@hyperion.valhalla.net>
Date: Wed, 02 Aug 2000 20:50:21 +0100
Subject: Updated DMASOUND patches
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <bh40@calva.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all sound testers (thanks again)

This is work-in-progress so these are convenience patches, rather than any
awesome finale :-)  (or should one say coda :-?)

I am, however, determined to make linuxppc sound at *least* as good as it is
under MacOS!!!

Patches for latest source trees at
http://www.drfruitcake.com/linux/linuxppc.html

This is the common 2.4.0/back-port codebase.  I haven't done a specific
2.4.0-test5 patch yet (but it's gonna be real close to the one there - and
the conditionals shouldn't hurt 2.4.0 - so...)

==========

Latest changes (both):

o   added in the detection of screamers (thanks Ben) solves some pismo
problems
o   a little extra information on which type of chip it thinks it has is put
into the status output

2.2.17pre15ben1:

o  drivers/sound/Makefile is updated with Geert's patch to correct
module_install stuff

===== my results so far.

2.2.17pre15 looks OK (same behaviour still )

2.4.0-test5

This is much more flaky **with identical code**  there is no crashing (yet)
- but a strong tendency for almost any activity to cut off the sound.
opening the mixer control is a really good way of doing it.  Once the panel
is open you can restart the sound and all is hunky-dory... but...

I guess I'm a little suspicious of the new wait-queue stuff (that's really
the only major change to the sound side).

Happy testing,
Iain

BTW sorry, no binaries posted  - I haven't done enough of my own testing yet.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
