Message-ID: <3BAA14FF.C7B7DBA1@mvista.com>
Date: Thu, 20 Sep 2001 11:10:39 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com> <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA96CA2.20EC30C8@mvista.com> <20010920075537.A13721@cpe-24-221-152-185.az.sprintbbd.net> <3BAA0C91.42E0910D@mvista.com> <20010920085109.E13721@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:
>
> On Thu, Sep 20, 2001 at 11:34:41AM -0400, Dan Malek wrote:
> >
> > Tom Rini wrote:
> >
> > > Well, because it keeps us from duplicating 4 lines in the makefile.
> >
> > OK.
> >
> > > .....  CONFIG_TREEBOOT could probably die, unless
> > > someone revives Oak or TiVo uses it.
> >
> > Walnut and Spruce use it.  Get it?  TREEboot?
>
> heh.  You're assuming that I get to see docs on these boards.  I forgot
> spruce uses it.  oak.h's board_info is the same as walnut, minus the PCI
> line.  And I dunno what TiVo uses...

The TiVo uses TREEBoot, with slight modification.  (There are some magic
values and such that have to be in the right place in the
bootloader....)

(The TiVo is an Oak reference board on steroids..)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
