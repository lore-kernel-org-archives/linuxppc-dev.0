Message-ID: <3BA10D1F.3F27E3C7@mvista.com>
Date: Thu, 13 Sep 2001 14:46:39 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Matthew Locke <mlocke@mvista.com>
Cc: "Donovan, Chris" <cdonovan@lanier.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Status on 403 (Oak) support
References: <C97ABDA0DC2DD511BA400002A50974132804F1@jdry.lanier.com> <3BA0FA9E.5010204@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Donovan, Chris wrote:
>

I (with the help of Matt Locke) are working with on 403GCX support.
It's in pretty bad shape right now.  If you are interested in helping, I
have some initial patches that fix simple 403 vs 405 differences.

--Mark

> > I'm trying to run linux on a board with a 403GCX processor on it. I ran into
> > an error while trying to compile the kernel as follows:
> >
> > {standard input}: Assembler messages:
> > {standard input}:83: Error: unsupported relocation type
> > {standard input}:84: Error: unsupported relocation type
> > {standard input}:111: Error: unsupported relocation type
> > {standard input}:128: Error: unsupported relocation type
> > {standard input}:145: Error: unsupported relocation type
> > {standard input}:149: Error: unsupported relocation type
> > {standard input}:64: Error: unsupported relocation type
> > make[1]: *** [ppc4xx_pic.o] Error 1
> > make[1]: Leaving directory `/d/ctemp/src/src-linuxppc_2_4/arch/ppc/kernel'
> > make: *** [_dir_arch/ppc/kernel] Error 2
> >
> > While searching the archives I found a thread which mentioned that that
> > kernel no longer compiles for the 403 processor and there was no mention of
> > a solution to the problem. Which version of the kernel should work on the
> > 403GCX? Thanks for your help.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
