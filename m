Message-ID: <20030228164733.30406.qmail@web41507.mail.yahoo.com>
Date: Fri, 28 Feb 2003 08:47:33 -0800 (PST)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: Question about modules
To: Ibon Gotxi Garcia <igotxi@jazzfree.com>,
	Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1046424964.385.3.camel@muse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

What abt System.map...
Can u check if symbols are there.

Bye
Bhupi


--- Ibon Gotxi Garcia <igotxi@jazzfree.com> wrote:
>
> I'm trying to write a simple module for an 8xx board
> using the SMC2.
> Everything works, till I try to insmod it: I get
> m8xx_cpm_alloc and
> m8xx_cpm_hostalloc as unresolved symbols.
>
> I think that arch/ppc/8xx_io/commproc.c is properly
> compiled (I can see
> both symbols on vmlinux), but somehow the build
> process strips them off
> as they are unused (i cannot see them in /proc/ksyms
> in the target). Is
> that right? Any clue to solve it? (having them in
> the target kernel
> without modifying the original sources)
>
> Many regards.
> ibon
>
> --
> Ibon Gotxi Garcia <igotxi@jazzfree.com>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
