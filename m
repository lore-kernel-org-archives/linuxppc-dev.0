Message-ID: <386A4C0F.712A4AAC@netx4.com>
Date: Wed, 29 Dec 1999 12:59:43 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pcmcia-cs for 8xx
References: <3869B35C.33986836@switchboard.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:

> What's the status about the 8xx pcmcia controller?

The hardware seems to work (mostly...).


> Wouldn't it be nice to use the pcmcia-cs package?


Maybe.  I have discussed this with several people over the
past year.  None of the product requirements I have seen
for 8xx PCMCIA need the capabilities of the pcmcia-cs.  They
didn't require hot swap or a variety of cards supported.  They
all fit a card before power up and it never changed.  All of
the projects I have done were "need it yesterday", so I just
used minimal functions to map the PCMCIA and get on with life.
I never had the time to port the pcmcia-cs package.  In the
embedded system, they didn't want the overhead of module
support programs, so these are also compiled kernel drivers.
The whole of pcmcia-cs assumes modules.

One difficulty with the PCMCIA on the 8xx is all board designs
I have seen use different power control methods, so the modifications
would include board specfic functions for this.

> Anyone done that already?

Not that I am aware.


> I saw some messages floating around about RPXLite 823.

Mark Mathews has wireless PCMCIA cards working, with some
weird hardware difficulty.

I have done several types of Flash card and some things I
can't talk about yet on the RPX-Lite PCMCIA.

> Is there anything I should know before I start digging?

There are lots of hardware variations.  The 860 has two PCMCIA
ports, sometimes boards use both or only one.  The 823/850 have
only PCMCIA B.  There are the pin multiplexing issues for the
8xx and the PCMCIA.  Some board designs intend to use PCMCIA,
but failed because they used the pins in a way that precludes
mapping them to the PCMCIA.

If you intend to do this, make sure you post your intentions
and progress.  I may make some of my time available to help out,
I just can't take on the whole project.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
