Date: Wed, 29 May 2002 12:54:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unrecognized opcode: `mtdcr'
Message-ID: <20020529195429.GP5997@opus.bloom.county>
References: <45B36A38D959B44CB032DA427A6E10640167CFD8@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167CFD8@cceexc18.americas.cpqcorp.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 02:30:16PM -0500, Cameron, Steve wrote:
> [..snip...]
> >
> > I think we need to change arch/ppc/Makefile from:
> > ifdef CONFIG_40x
> > CFLAGS := $(CFLAGS) -Wa,-m405
> > endif
> >
> > To:
> > ifdef CONFIG_4xx
> > CFLAGS := $(CFLAGS) -Wa,-m405
> > endif
>
> Ok, this worked for me.  Thanks!  (I guess I wasn't so
> far off track after all.)
>
> > For the moment.  Until there's some 440-specific opcodes we use (are
> > there any?) which means we'll need to do -Wa,-m440.
>
> When I had tried "-Wa,-m440" before, it wasn't recognized as an option.
> (but perhaps by "do -Wa,-m440", you mean enhance the C compiler and/or
> assembler.)

Well, iff there's 440-specific opcodes, at somepoint gas will know about
them, and we can use -Wa,-m440, or so.  But for now -Wa,-m405 seems
correct for 4xx.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
