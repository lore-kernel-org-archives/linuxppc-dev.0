Message-Id: <199908310731.DAA25842@nerd-xing.mit.edu>
To: "David D. Kilzer" <ddkilzer@computer.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card 
In-Reply-To: Your message of "Tue, 31 Aug 1999 00:26:35 CDT."
             <v03130301b3f116a864e2@[192.168.1.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Aug 1999 03:31:49 -0400
From: "Charles E. Leiserson Jr." <locutus@MIT.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Is anyone running LinuxPPC with a Daystart 604e 200MHz dual-processor 
> >card?
> 
> Hmmm...must have been half-asleep when typing that.  Yes, it's a 
> Daystar nPower processor card with dual 200 MHz 604e PowerPC CPUs.
> 
> Here's what's left of the boot messages on the screen in 2.2.12 from 
> CVS that I compiled on Aug 29, 1999:
> 
> 
> POSIX conformance testing by UNIFIX
> Entering SMP Mode...
> Processor 1 is stuck.

The "processor stuck" message should be fixed if you do a cold boot (ie. shut 
the machine down completely).  You shouldn't have any more problems like this 
after the first successful boot.

> Kernel panic: machine check
> Rebooting in 180 seconds..
> 
> 
> The part about "Processor 1 is stuck." doesn't look good, then we get 
> the big OOPS.

Sounds like you have compiled something in that your computer doesn't like...
Have you tried my kernel (R5)?


					- Ricky


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
