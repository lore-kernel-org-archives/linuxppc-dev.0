Message-ID: <3AED9DB8.7B15F60D@mvista.com>
Date: Mon, 30 Apr 2001 13:15:36 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linuxppc-embedded@lists.linuxppc.org, cort@fsmlabs.com,
	Alexandre.Nikolaev@matrox.com
Subject: Re: ppc little-endian port
References: <200104282316.f3SNG7D365341@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Albert D. Cahalan" wrote:

> I'm going to tackle it. Alexandre Nikolaev already is tackling
> it I guess.

That's way beyond the scope of discussion or interest on this
list.  Make sure you contact the proper tools, library, and
application folks.

> Lots of PowerPC processors run in little-endian mode today.

Lots?  Maybe a few.  Since the first days of PowerPC I have only
seen one ill-fated attempt.  Every time I'm part of a PPC silicon
design discussion the question is always raised whether it is
worth wasting silicon trying to support it.

It's getting harder to use little endian on PowerPC.  The 7450 has
only a big endian bus, with some weird lane swapping internally.
Misaligned little endian accesses still cause processor exceptions,
and the 7450 states it doesn't support it at all (some contradiction
here), so you are always at a performance disadvantage when using
it.  Besides, the bytes are all backward from the normal order of
the world and you end up spending cycles swapping them, anyway :-).

> .... Modern medical scanners (CAT, MRI, PET...)
> all use little-endian PowerPC processors.

It can't be all, because I have worked on some prototypes in the
past that weren't.

> Opinions on this don't matter when you put a 7400 on a PCI board
> and try to share memory with an x86 host computer.

My opinions always matter :-).  In this case you should be using
a big-endian PowerPC host computer, too.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
