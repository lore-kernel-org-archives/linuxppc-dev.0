Date: Sun, 28 May 2000 14:03:09 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Robert Thompson <rothomp3@vt.edu>
cc: linuxppc-dev@lists.linuxppc.org, Stephan Leemburg <stephan@jvc.nl>
Subject: Re: Debian pmud package available
In-Reply-To: <B555F58A.7D5%rothomp3@vt.edu>
Message-ID: <Pine.LNX.4.10.10005281352260.21987-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> Where can I get the RPMS or tar files.
> >
> > http://www3.jvc.nl/linuxppc/
> >
> >
> OK, so, I got the source, applied the patch I found, and built it. Well, I
> tried to... it failed because pmu.h redeclared something that was in some
> system header of the same name... I commented out the thing in pmu.h

That's OK, I had to do the same when building with 2.2.15 kernel headers.
Debian ships with 2.2.10 (at least the pre-release version I installed had
2.2.10 headers) so I left it that way. Stephan apparently didn't compile
pmud with 2.2.15 headers either. If it was a simple #define we could work
around it, but it defines an additional element in the PMU version enum
and I don't know how to test for that (short of mucking with configure
tricks, of course). Just ignore it for now.

If the Debian powerpc release kernel is 2.2.15 I'll take care of that in
the Debian package. What you got was Stephan's LinuxPPC package, I can't
update that one, obviously.

CC: to Stephan (no idea if he's on the list), please contact him for
further questions.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
