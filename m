Message-ID: <3BC4F03F.85FD2557@india.infogain.com>
Date: Thu, 11 Oct 2001 06:35:03 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to boot linux on sandpoint board ?
References: <20011011053513.17120.qmail@mailweb19.rediffmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:
>
> Hi every1,
>  Thanx for quick replies. Was a good introduction.
>  But I have some more doubts.
> > Yes!... Linux has to be changed based on Architecure,
> > and the board (chipset). And for additional devices,
> > we can put in device drivers as necessary. For
> > example, port for PPC is different from
> > port for ARM or x86.
>   Yeah,I can understand that linux for PPC is diff from
>   linux for x86. But how come linux for PPC is diff
>   from Linux on a sandpoint. For exp, in an IBM board,
>   PIC always sits at IO addresses 0x20 and 0xA0. In any
>   IBM board, whether it is for a PC or for a minimal
>   board, the basic chipsets and their IO address space
>   assignments (Which are hardwired, as in case of PIC,
>   8254) remain the same. So, if we need to run a
>   desktop OS on a minimal board, the changes involved
>   would be less. This is my understanding. Correct
>   me if I am wrong. Coming to point, has sandpoint
>   board got some additional chipsets ? or has it got
>   the same chipsets arranged in a diff way, i mean

you should understand the fact that PPC is a general term.
don't be overcarried away by this..

there can be many processors based on PPC.
Likewise Sandpoint is a board where different processors can go as
PPMC card.

issues can vary with every combination .
things to start with high level idea of general PPC arch.
and manual of processor you are using.
first target should be successful booting.
as a shortcut tip booting you can get happening by setbat() and ioremap()
manipulations if reqd.also for your help there are discussions in this archive .
you can debug during booting by sending some characters on serial port.
but do it cautiousely as it may cause hang at some places if address decoding of that is not
setup during initialization .

later on  sandpoint porting requires little more effort in terms of
peripheral support and interrupt (EPIC) initialisation.
but you should target these two later.
to the best of my remembrance I had used sandpoint on MODE 0 and 1 only.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
