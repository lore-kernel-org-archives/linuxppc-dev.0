Message-ID: <3678367F.B4519A13@jlc.net>
Date: Wed, 16 Dec 1998 17:38:55 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@ladron.cs.nmt.edu>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Embedded 8xx update
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




I have been fielding lots of personal e-mail lately about
the embedded LinuxPPC ports, so I thought I would take
a minute and post some notes.

I have some boot rom software that I used in my 860T/FADS
board, and a 2.1.127 kernel that usually boots on that
board.  I placed them in the embedded directory of
linuxppc.cs.nmt.edu.  The rom software is a collection
of stuff from Motorola and adapted Linux kernel functions.
Probably the most important is it contains working UPM
programming for 100 MHz SDRAM on a 50 MHz bus.
I hope it will serve as a base for anyone to do something
more.  I have no intention of updating it.  It served its
purpose for me and should be used as a reference.  I
am only going to work on hardware with real debug monitors
from now on :-).

I am working on, and have finished, several ports to
821, 823, 850 processor boards.  I am trying to merge
all of this into the 2.1.131 baseline, including making
useful modifications to the configuration scripts.  I
hope to have this done soon, and the upcoming holidays
will probably allow that to happen.

If anyone needs a port to one of these processors or
other type of board, let me know and I can probably
help out rather quickly, hopefully saving you from
replicating anthing I have done.  Prior to having
everything merged into the baseline, I could probably
be convinced to drop a tarball on the server sometime.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
