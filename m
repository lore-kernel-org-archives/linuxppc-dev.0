Date: Wed, 19 Jun 2002 08:51:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
Message-ID: <20020619155106.GD12762@opus.bloom.county>
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de> <20020619150520.GA12762@opus.bloom.county> <3D10A0AC.409EF92B@imc-berlin.de> <20020619152528.GB12762@opus.bloom.county> <3D10A455.7682EF16@imc-berlin.de> <20020619154111.GC12762@opus.bloom.county> <3D10A786.A712DC47@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D10A786.A712DC47@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 19, 2002 at 05:47:18PM +0200, Steven Scholz wrote:
> Tom Rini wrote:
> > > So when can I "bk pull" these changes then, Tom?
> >
> > Shortly after I see if 2.5.23 boots/compiles for classic PPC :)
>
> What do you mean? RPX Classic?

No, 6xx/7xx/74xx boards.  Or more specifically the motorola lopec I've
got up on my desk here. :)

There's already a few things that need to be fixed, and then I'll push
that (And wait until we can start the _devel resync before pushing it to
2.4).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
