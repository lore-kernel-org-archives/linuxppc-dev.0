Date: Tue, 9 Apr 2002 12:47:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020409194721.GI1331@opus.bloom.county>
References: <20020409145222.GB710@opus.bloom.county> <0204091923.AA23957@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204091923.AA23957@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 12:23:57PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Well, take a look at what the file used to look like in _devel.  It was
> > around 30-40 lines of that.  Which is not nice to look at.
>
> So what's more important, a pretty look or better functionality for the user?
>
> > Well, it's a much better system if you want to group unlike hardware
> > together in one kernel. :)
>
> Which is what I want to do, and which is the RTTD for distributions like
> Debian.

Taking debian as an example here.  You certainly wouldn't stick a zImage
for every board into 1 package.  Why?  It'd be a 20mb package and as it
is a few people dislike the number of vmlinux's in the -pmac package.
So you only 'win' if you have a common, _bootable_ image on all of these
boards.   And while it is possible that there could be a common
firmware, I'm not holding my breath. :)

And the other point is that this makes it less clean to add in a new
board port.

> > Well, if ISA slots exist on the board, and should be working, they
> > should just work.  And when BenH merges in prep/chrp, it'll be needed.
> > But the question is do you really want to offer this up on machines
> > where it's not tested?
>
> I want to have configurable CONFIG_PCI and CONFIG_ISA support for
> CONFIG_GENERIC_PPC32. Generic means that things like this must be
> configurable.

But what if they aren't really configurable?  You could turn off
CONFIG_PCI, but I don't think you'd get too far on most[1] systems.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

[1]: Most, not all, most.  I know there's 8xx and others...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
