Message-ID: <19990913092728.D313@albireo.ucw.cz>
Date: Mon, 13 Sep 1999 09:27:28 +0200
From: Martin Mares <mj@ucw.cz>
To: mlan@cpu.lu, Paul.Mackerras@cs.anu.edu.au
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More on Various PMac PCI patches
References: <199909122137.XAA00332@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199909122137.XAA00332@piglet.cpu.lu>; from Michel Lanners on Sun, Sep 12, 1999 at 11:37:43PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Here is another round of PCI patches for the PowerMacs, against 2.2.12
> official.
> 
> It includes all my previous patches, cleaned up a bit, with the special
> cases upon region enabling removed for VGA and IDE, and with special
> care for PlanB. That's since with OF's assignments, PlanB collides with
> the memory held by control.
> 
> I haven't had time to investigate the potential PCMCIA problems nor
> find an appropriate solution, so this PCI stuff might need to change
> further. I just wanted to get it out the door, since more and more
> people seem to be bothered by the lack of fixup code for the PCI bus.
> 
> Enjoy, and report any and all problems to me!

   It looks OK to me, but of course I'm no PPC expert...
 
				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"This message transmited on 100% recycled electrons."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
