Date: Thu, 20 Sep 2001 14:56:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010920145632.A17555@cpe-24-221-152-185.az.sprintbbd.net>
References: <EFEAIMDCOOOHIEPHDNFJEEMCDCAA.stefan.roese@esd-electronics.com> <3BAA093A.10E96272@mvista.com> <20010920084607.D13721@cpe-24-221-152-185.az.sprintbbd.net> <3BAA62EE.2006422D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BAA62EE.2006422D@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 05:43:10PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> > .... In some parts of the PPC world, we can't/don't for various
> > reasons (technical and/or ingrained).
>
> I can't think of any that don't......Help me remember :-).

heh.  Well, chrp and pmac really should use yaboot or something similar.
I'd go as far as to say on a machine which reasonably could be used for
desktop (and thus the choice of multiple kernels) you want something to
find where they are and let you pick one.

> > ....  For example, I don't see a problem
> > with something which takes a vmlinux.gz and boots it.
>
> First of all, someone has to uncompress it.  Then someone has
> to handle any initrd loading.  Then someone has to handle command line
> and other parameter passing.  Then.....

In other words, do all of the stuff the in-kernel 'bootloader' does.
I don't think this is a problem in a stable line.  This stuff shouldn't
change in a way that's not backwards compat.   We've diddled this
a bit along the way in 2.2 and 2.4 I'm sure, but we shouldn't.

> > ....  But we should define what we're going to do before we do
> > it so that yaboot/ppcboot and apus can figure out how much re-working
> > they'll need and whatnot..
>
> Well, I trusted Ben to provide some of this information.  Mind you,
> it was only a few lines on IRC, but it started with moving all of
> the cputable initialization stuff into the bootloaders......and went
> downhill from there :-).

heh.  Well, I do think we should outline what we're going to attempt to
do a bit and then throw out some code that does it.  There's other
people who for some reason or another want to have a bootloader external
to the tree, and I think that's a good idea.  I'd go as far as yanking
our in-kernel crap out and making it it's own package once we got things
settled down perhaps...  But that's just my opinion. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
