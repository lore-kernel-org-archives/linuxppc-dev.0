Message-Id: <l03130303b38a1ad611d6@[216.67.3.175]>
In-Reply-To: <199906110911.LAA32422@denx.muc.de>
References: Your message of "Fri, 11 Jun 1999 09:23:16 +0200."            
 <3760B964.E1424E37@switchboard.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 13 Jun 1999 22:41:22 -0400
To: Wolfgang Denk <wd@denx.muc.de>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: MPC8xx: Bad emulation
Cc: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:11 AM -0400 6/11/99, Wolfgang Denk wrote:
>There are *many* situations where it is really necessary to  be  able
>to run _any_ binary from a standrad LinuxPPC distribution on the 860,
>too.  I agree that it makes sense to recompile dedicated applications
>for an embedded solution.

Then what you may wish to do is develop a software FPU for the PPC860. That
is, have the OS patch the illegal instruction trap so that it jumps to
emulation code when the instruction is an FP instruction.

I'm surprised. I thought we were already doing this.  This sort of thing
has been done forever on the 68k to emulate the 68881/2 FPU. It's slow but
if you don't plan on doing much floating point, it's perfectly acceptable.



_______________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
_______________________________________________________________________



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
