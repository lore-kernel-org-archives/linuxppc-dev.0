From: flar@marcus.pants.nu
Message-Id: <200005200554.WAA26536@marcus.pants.nu>
Subject: Re: hfs
To: dan_bethe@yahoo.com (Dan Bethe)
Date: Fri, 19 May 2000 22:54:55 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000503221141.6962.qmail@web1003.mail.yahoo.com> from "Dan Bethe" at May 03, 2000 03:11:41 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Bethe wrote:
> > I'm under the impression that HFS is basically a subset of HFS+, i.e.
> > HFS+
> > working should fix HFS.  I could easily be wrong, though.
> 	Well I would guess that it would, but not automatically.  If you go to
> an OS that only supports HFS, and you mount an HFS+ filesystem, it will
> work but only one file will be available.  It's the magic file entitled
> "Where have all my files gone?" or something like that.  So technically
> HFS+ is a superset of HFS.  :)

No, HFS+ is similar to HFS, and an HFS+ filesystem can be (and usually is)
wrapped in an HFS filesystem.  All that needs to be read out of the HFS
filesystem to get to the HFS+ filesystem is about a dozen bytes of the MDB.

> 	I guess there are a bunch of people speculating all day rather than
> coding it, which is understandable.  Perhaps the primary maintainers of
> the most prominent HFS+ and HFS code can surface and let people know
> what they're doing, and what they need help on.  Or maybe they'll just
> pop up one day and say "Hey we're all done!  Here ya go!"  :^)

No, there's a bunch of people that have things they are being paid to do
that take up most of their time.  I am the lead of the HFS+ code, and I
know I haven't had time to touch it in about 5 or 6 months.  The other
people who are helping me aren't much better off.  If other people want
to help, they're welcome...

	Brad Boyer
	flar@pants.nu

P.S.: I've been exceptionally busy the last few weeks, and I'm way behind
in my list mail...  Now that E3 is over, I should have a little more time.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
