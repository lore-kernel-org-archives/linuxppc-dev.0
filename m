Message-ID: <3D0E2073.989C8826@imc-berlin.de>
Date: Mon, 17 Jun 2002 19:46:27 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Wolfgang Denk <wd@denx.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <20020617153255.GS13541@opus.bloom.county> <20020617172510.22BB1102FB@denx.denx.de> <20020617173550.GV13541@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> > -  is
> > the  only  way  to  get  ANY  patches  into the _working_ tree really
> > through 2.5?
>
> Well, for the moment I'd like to try that.  Considering there's really 4
> (kernel.org, linuxppc_2_4, linuxppc_2_4_devel, DENX) trees people use right
> now, I'd like to try and remove at least one of those.
>
> And since we're stuck between a rock and a hard place, wrt killing
> 2_4_devel right now, lets use linuxppc-2.5 (or linux-2.5) which has
> 98% of the changes in _devel (and I think 100%, wrt 8xx).
>
> > Why must we  go  through  the  pain  to  fix  a  lot  of
> > unrelated problems in a tree we don't really care about (yet) just to
> > fix things?
>
> Fixing 2 things.  And it will be a lot less painful now trying to fix 2,
> recently broken things, rather than waiting 6 months to fix 5 or 10
> broken things spanning 6-8 months.

Tom,

does that mean that you will _not_ accept small patches fixing small
problems!?

I can remember you (?) always telling the people the split their patches
into small pieces doing one thing at a time!

So why not fix first things first?

The DEFINES I am talking about are Ethernet related (SCC/FEC). I think
they should move into the board specific header files. And they have
nothing to with the I2C stuff! Or did I miss something?

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
