Message-ID: <3AE4E93E.AC7C788C@mvista.com>
Date: Mon, 23 Apr 2001 22:47:26 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
Cc: Alexandre.Nikolaev@matrox.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc little-endian port
References: <3AE47B3C.8DF8F330@matrox.com> <20010423181550.F13368@ftsoj.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cort Dougan wrote:
>
> Why?

Yeah, we really don't care about little-endian.  Like I always
say, getting a kernel built and booted is the easy part.  The
entire world runs big endian tools, libraries and applications.
Making all of that work is a task no one is going to tackle.

While refreshing my PowerPC history the other day, I found a UISA
book from 1991.....The Little-Endian Byte Ordering chapter introduction
has this to say:

	It is computed that eleven Thousand Persons have, at several
	Times, suffered Death, rather than submit to break their
	Eggs at the smaller End.  Many hundred large Volumes have been
	published upon this Controversy...

			Jonathan Swift, "Gulliver's Travels"

Later in the text it states "There are 24 ways to specify the
ordering of four bytes withing a word, but only two of these
orderings are sensible."

I contend there is only one sensible ordering, and we are already
using it.........


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
