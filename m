Message-ID: <19990815112058.Q145@albireo.ucw.cz>
Date: Sun, 15 Aug 1999 11:20:58 +0200
From: Martin Mares <mj@ucw.cz>
To: mlan@cpu.lu, Paul.Mackerras@cs.anu.edu.au
Cc: paulus@cs.anu.edu.au, drow@false.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
References: <199908100010.KAA19153@tango.anu.edu.au> <199908100538.HAA00316@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908100538.HAA00316@piglet.cpu.lu>; from Michel Lanners on Tue, Aug 10, 1999 at 07:38:38AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

> Exactly what I meant. I feel drivers shouldn't read addresses directly
> from config space, but rather from the pci_dev struct, so that any
> necessary pcibios_fixup() can be made. By the way, the same is true for
> interrupts....

   They really shouldn't and I hope I've already fixed all drivers
in the kernel not to do that.

   Actually, it's already documented in Documentation/pci.txt :-)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Computers are useless.  They can only give you answers."  -- Pablo Picasso

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
