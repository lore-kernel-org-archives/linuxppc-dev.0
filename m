Date: Mon, 16 Jul 2001 11:57:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Larry McVoy <lm@bitmover.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel ftp ?
Message-ID: <20010716115734.P29668@work.bitmover.com>
References: <20010716111241.M29668@work.bitmover.com> <Pine.LNX.4.10.10107162014480.20269-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10107162014480.20269-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Mon, Jul 16, 2001 at 08:38:17PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 16, 2001 at 08:38:17PM +0200, Michael Schmitz wrote:
> Thanks for your understanding - in my case it's just inertia at work. Plus
> there doesn't seem to be a Debian or RPM package I could find. I don't
> follow kernel development closely, I don't need to commit patches, even a
> source tarball snapshot posted to some big FTP archive would suit me fine.

http://www.bitmover.com/download

There is no RPM but the binaries all go in one place.  Complain loadly enough
and we'll make RPMs.

> > Our way around this problem is to get you to do one "bk clone" and only
> > "bk pulls" after that.  That will transfer _only_ the data which has to
> > be transferred, nothing else.  Even that is a substantial amount when
> > you multiply it all out by the number of people.  We'll deal with that,
> > we won't deal with full copies.
>
> Color me naive but wouldn't a second tier of bk or other sites alleviate
> that? Provided they won't allow commits so syncing the repositories won't
> get to be a headache?

Sure that would work fine but it still means you have to install BK to
get the data.  But if you do that, yes, it makes tons of sense to have
a pile of hosts around the world providing mirrors.  And we can set it
up such that we auto-push to them from here when new stuff comes in.

I think the point I'm trying to make is that _nobody_ can afford to
provide infinite bandwidth for free.  I don't support the Mvista choice
of doing so one little bit, I think it is self destructive.  Even if
they are making money from Linux/PPC, why throw it away needlessly?
Last year there was so much money floating around the valley that noone
worried about a few grand a month.  This year people are being laid off
right and left, partially because of wasteful decisions.  I'm from the
MidWest of the US, where people are well known for "waste not, want not".
I don't see why bandwidth shouldn't fall under that as well.  And BK rocks
as a mirroring service, it's amazingly good.  One of our developers is
behind a modem.  BK works great (he hates life because surfing the net
sucks, but the BK part is fine).

I think 5 years from now you'll see people using BK, or things like it, for
doing mirroring all over the world.  It works.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
