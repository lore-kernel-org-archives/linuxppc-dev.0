Message-ID: <19990815112336.R145@albireo.ucw.cz>
Date: Sun, 15 Aug 1999 11:23:36 +0200
From: Martin Mares <mj@ucw.cz>
To: mlan@cpu.lu, Geert.Uytterhoeven@cs.kuleuven.ac.be
Cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
References: <Pine.LNX.4.10.9908082252170.23564-100000@mercator.cs.kuleuven.ac.be> <199908082121.XAA03124@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908082121.XAA03124@piglet.cpu.lu>; from Michel Lanners on Sun, Aug 08, 1999 at 11:21:59PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

> That's even worse.... Might be one more reason for Martin to get the
> dynamic resource allocation stuff for PCI devices into the kernel ;-)

   ;-))  I'm working on that, the most problematic bit is currently
to get Linus at least reply to my patches :|

   On the PPC, do you have enough information about host bridges, so
that you can re-address all the devices? Whereever this way is possible,
I'd prefer it over mixing addresses assigned by the firmware and the
kernel as it's hard to get right if there are any PCI to PCI bridges.

   I'll probably add a generic helper function for the whole address
assignment / card enabling business.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"f u cn rd ths, u cn gt a gd jb n cmptr prgrmmng."

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
