Message-ID: <3B3C38D9.2519DA96@mvista.com>
Date: Fri, 29 Jun 2001 04:14:17 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Neil Wilson <NWILSON@Airspan.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Sandpoint 3 + MPC7450 + HHL2
References: <E69FF45ADA3BD511A25900047623CC4F12AA74@JUPITER>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Wilson wrote:

> I managed to get the JourneyMan 2 82XX booting up on my Sandpoint3 MPC7450 -

I'm sitting on a bunch of changes for both Sandpoint X3 and 7450.  With
the new cputable stuff in 2.4_devel, I'll stuff the 7450 changes in
there.

The X3 changes are a big hack to OpenPIC, because the X3 uses the
serial interrupt interface of the EPIC.  I'm still working with Motorola
to understand some discrepancies in the way the board is supposed to
work,
and the way it does.  That is, I have some additional hacks that make
the
board work, but it isn't right.

I'll work on all of this over the weekend.

> ...after adding a enable for the TimeBase

So, you have an old version of DINK.  Get it updated as you are probably
missing more than that.

I don't know what Motorola is shipping to their customers.  I have had
many revisions of hardware and silicon, and just recently have the L2
cache working.  I never received a board with a working L3 cache.  I
guess
there are some magic parts required, and they are ending up in the
hands of people more important than me :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
