Date: Sat, 28 Aug 1999 13:27:47 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <19990827112042.001235@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9908281327290.8134-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 27 Aug 1999, Benjamin Herrenschmidt wrote:
> On Thu, Aug 26, 1999, Tom Rini <trini@kernel.crashing.org> wrote:
> 
> >> Thus I can remove the nvram code from atyfb?
> >
> >Why?  It works fine on lots of older machines w/ ati cards and older MacOS
> >versions.  If you remove it I can garrenty people will notice and
> >complain.
> 
> We should get rid of it for atyfb once we have DDC working. According to
> Apple, all machines with ATI controllers are using DDC now. The nvram
> setting would still be useful for the older video controllers.

The NVRAM code should be separated from atyfb, so it can be used by all Mac
drivers.

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
