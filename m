Subject: Re: Question about modules
From: Ibon Gotxi Garcia <igotxi@jazzfree.com>
To: bhupinder sahran <bhup_sah@yahoo.com>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030228164733.30406.qmail@web41507.mail.yahoo.com>
References: <20030228164733.30406.qmail@web41507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1046452804.385.47.camel@muse>
Mime-Version: 1.0
Date: 28 Feb 2003 17:20:04 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-02-28 at 16:47, bhupinder sahran wrote:
> Hi
>
> What abt System.map...
> Can u check if symbols are there.
>
yes, they are, as well as in vmlinux. In my top level Makefile I find:

$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw]
\)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map

but I think that in the step of making zvmlinux, unneeded symbols _may_
be stripped off, because i cannot find all the symbols in the target (in
/proc/ksyms or with ksyms -a). Am i right?

Thank you for answering, anyway.

Cheers
Ibon.

> Bye
> Bhupi
>
>
> --- Ibon Gotxi Garcia <igotxi@jazzfree.com> wrote:
> >
> > I'm trying to write a simple module for an 8xx board
> > using the SMC2.
> > Everything works, till I try to insmod it: I get
> > m8xx_cpm_alloc and
> > m8xx_cpm_hostalloc as unresolved symbols.
> >
> > I think that arch/ppc/8xx_io/commproc.c is properly
> > compiled (I can see
> > both symbols on vmlinux), but somehow the build
> > process strips them off
> > as they are unused (i cannot see them in /proc/ksyms
> > in the target). Is
> > that right? Any clue to solve it? (having them in
> > the target kernel
> > without modifying the original sources)
> >
> > Many regards.
> > ibon
> >
> > --
> > Ibon Gotxi Garcia <igotxi@jazzfree.com>
> >
> >
>
>
--
Ibon Gotxi Garcia <igotxi@jazzfree.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
