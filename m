Date: Sun, 4 Jul 2004 11:32:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stef Simoens <stefaan.simoens@coditel.net>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040704183255.GD2146@smtp.west.cox.net>
References: <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <40E75DC7.7070601@coditel.net> <20040704024149.GB2146@smtp.west.cox.net> <Pine.GSO.4.58.0407041028480.21842@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0407041028480.21842@waterleaf.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 04, 2004 at 10:32:52AM +0200, Geert Uytterhoeven wrote:

> On Sat, 3 Jul 2004, Tom Rini wrote:
> > On Sun, Jul 04, 2004 at 03:30:47AM +0200, Stef Simoens wrote:
> > > Olaf Hering wrote:
> > > > On Tue, Jun 15, Tom Rini wrote:
> > > >>And yes, passing -many does work on all older supported versions of
> > > >>binutils.  So perhaps we should just add -Wa,-many to our cflags and be
> > > >>done with it now (and for future fixes of this sort).
> > > >
> > > >gcc 3.2 passes only -mppc, so all altive instructions will fail to
> > > >compile without either -many or -maltivec
> > >
> > > Are there altivec instructions when CONFIG_ALTIVEC is not set?
> >
> > Yes.  And I can forsee in the future were we might have BookE specific
> > ones in the same situation.
>
> Perhaps it makes sense to add a directive to the assembler to switch on the
> fly, cfr. the `.chip' directive on m68k? E.g. using

AFAIK, the problem which caused the need for introducing -maltivec was
a problem with the disassembler and conflicting opcodes.  It should still
be able to check the validity of things with -many (I would hope..).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
