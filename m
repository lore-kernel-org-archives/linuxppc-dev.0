Message-ID: <19990130020006.A580@toocool.calpoly.edu>
Date: Sat, 30 Jan 1999 02:00:06 -0800
From: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
To: mlan@cpu.lu, O.Waller@ee.qub.ac.uk
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody?
References: <Pine.SGI.4.02A.9812151054230.11112-100000@myst.ee.qub.ac.uk> <199812172146.WAA00356@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199812172146.WAA00356@piglet.cpu.lu>; from Michel Lanners on Thu, Dec 17, 1998 at 10:46:30PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Add me to the list of people playing with matroxfb and controlfb.

Does anyone have some fbset outputs suitable for fb.modes for the
matrox Mil I card?  I'm having a heck of a time trying to change from the
default mode.  In Documentation/fb/matroxfb they talk about passing kernel
parameters to set the modes, but whenever I do that the kernel panics
before ever spitting anything out.  I assume it's a "no bios" thing.
I'm hoping someone with a Mac version of the card might already have
the various timings etc that fbset wants, and that they'll be the same
as the PC version.

And the one other simple question... how in the heck do you tell 
XF68 which /dev/fb* to go to?  Right now I'm moving the devices
around by hand, but I'd eventually like to get a Dual headed X setup
going.

...aside...

I'm running an x86 Matrox card in my 8600, and it "sort of" works
right now on 2.2.0.  It appears that there are definitely some kernel
bugs as far as mode switching, as sometimes control and matrox end up
duplicating each other resulting in very funky displays.  I had to hack
the kernel slightly, in that it assumes if you have a Mac, well then you
must have a Mac matrox card, and OF should take care of initialization.
Nope, I've got a x86 card, and it has to be initialized by the kernel.
Simple one line hack in the init function for matroxfb.  

Thanks for any input.

-- 
Daniel Kerry Hiltgen     Computer Science     Cal Poly, San Luis Obispo, CA  
dhiltgen@www.itslab.calpoly.edu    http://www.itslab.calpoly.edu/~dhiltgen/

"In a world without fences who needs Gates?"  1997 JavaOne Conference

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
