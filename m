Date: Wed, 25 Aug 1999 10:46:33 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <199908250426.OAA00893@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.10.9908251045280.23842-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Aug 1999, Paul Mackerras wrote:
> Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:
> 
> > Thus I can remove the nvram code from atyfb?
> 
> Well, what's there doesn't seem to be much use.  OTOH, we really do
> need something to make it less likely that a newbie will be confronted
> by a blank screen because they forgot to put "video=atyfb:vmode:17" in
> their kernel command line.  Maybe it should look at the registers and
> see if the chip is already running, and if so, just use whatever
> timings the chip is currently set to (as long as they look sane).  Or
> maybe there needs to be some intelligence somewhere that looks at the
> `compatible' property on the device-tree root node and says "aha, an
> iMac, default to 1024x768@75Hz".

The default video mode should be chosen depending on the machine type.

> I see that there properties called "ATY,DefaultMode" and
> "ATY,DisplayMode" on the device-tree node for the ATI chip on my G3
> desktop.  They both have the value 30 (0x1e).  I don't know what mode
> 30 is.

Look at the OF `words' of that node. There should be a function to get the
supported video mode list.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
