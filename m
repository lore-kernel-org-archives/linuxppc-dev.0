Message-ID: <37C64B33.27CD4058@agelectronics.co.uk>
Date: Fri, 27 Aug 1999 09:24:19 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: bug in l2cr status display?
References: <199908262105.XAA03192@piglet.cpu.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
> It seems that the effect of the L2CR[DO] bit isn't clear. In the 750
> user manual, in the table describing l2cr, it says '... setting  this
> bit enables the caching of instructions'. This doesn't corrsspond to
> the name of the register, nor to what I see with my G3 upgrade card: in
> normal operation, L2CR[DO] isn't set, but it makes no sense to disable
> instruction caching excpet for test purposes.
> 
> So, what's happening? Is the user manual wrong? In that case, we should
> correct arch/ppc/kernel/ppc_htab.c accordingly.

I think I posted a patch for this a while ago, but I've sort of lost
track. Basically, somebody in Motorola's documentation department
couldn't tell one from zero. In normal use the bit should be clear.
Hopefully somebody with write access will get the correct form into CVS.

They also got the Branch Target Instruction Cache the wrong way round. I
just hope that all firmware developers for G3 machines noticed these
mistakes.

> Any Motorola engineer around? Others with better docs? FWIW, I checked
> the 750 errata already... nothing.

It's in the errata to the manual, not the errata to the chip.

- Adrian Cox, AG Electronics

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
