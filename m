Message-ID: <3BAA62EE.2006422D@mvista.com>
Date: Thu, 20 Sep 2001 17:43:10 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <EFEAIMDCOOOHIEPHDNFJEEMCDCAA.stefan.roese@esd-electronics.com> <3BAA093A.10E96272@mvista.com> <20010920084607.D13721@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> .... In some parts of the PPC world, we can't/don't for various
> reasons (technical and/or ingrained).

I can't think of any that don't......Help me remember :-).

> ....  For example, I don't see a problem
> with something which takes a vmlinux.gz and boots it.

First of all, someone has to uncompress it.  Then someone has
to handle any initrd loading.  Then someone has to handle command line
and other parameter passing.  Then.....

> ....  But we should define what we're going to do before we do
> it so that yaboot/ppcboot and apus can figure out how much re-working
> they'll need and whatnot..

Well, I trusted Ben to provide some of this information.  Mind you,
it was only a few lines on IRC, but it started with moving all of
the cputable initialization stuff into the bootloaders......and went
downhill from there :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
