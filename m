Date: Wed, 19 Jun 2002 14:22:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
Message-ID: <20020619212246.GA16052@opus.bloom.county>
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de> <20020619150520.GA12762@opus.bloom.county> <3D10A0AC.409EF92B@imc-berlin.de> <20020619152528.GB12762@opus.bloom.county> <3D10F388.5@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D10F388.5@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 19, 2002 at 05:11:36PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> >On Wed, Jun 19, 2002 at 05:18:04PM +0200, Steven Scholz wrote:
> >
>
> >>Hmm. Don't know. Maybe. But these are just DEFINES! So what should that
> >>be bad?
> >
> >
> >Oh yeah, right..  Hmm, it probably won't break anything then..
>
> But, that's not the point.

Well, since I was referring to C-code in a #define in a file included by
asm files, it was the point. :) But I added __ASSEMBLY__ tests to the
files that neeed it 'n such since it does work but isn't really
correct..

> The 2.4 source base is no longer supposed to be a development base.
> The code works fine as it is, moving a bunch of #defines around because
> some people like it that way isn't giving us any feature enhancement and
> opens the door for making mistakes.

Maybe I won't move it into 2.4 right after the _devel merge.  We'll
see..

> I personally like the file the way
> it is because it is the logical collection of all communication processor
> related information regardless of the board.  I'm sorry others don't
> like it that way.

Yes, but it's putting board-specific information in a board-independant
file.  That doesn't seem right.

[snip]
> thing that should be happening in the 2.4 tree is bug fixing.  The 2.4
> kernel is what it is, like it or not.  If you want something new and
> different,
> it belongs in the 2.5 tree to show up at some point in the future.

And in the (un)fortunate grand linux tradition, new features with some
demand from the users behind them get backported too.  For example,
2.2.current (21? 22?) has all sorts of compat glue for 2.4 drivers and a
rather current USB stack and all sorts of things like that..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
