Date: Tue, 24 Aug 1999 14:56:45 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <19990824110229.025988@mail.mipsys.com>
Message-ID: <Pine.LNX.4.10.9908241456210.17842-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Aug 1999, Benjamin Herrenschmidt wrote:
> On Tue, Aug 24, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:
> >The second is that macos is now using mode numbers > 20.  I haven't
> >worked out the correspondence yet.
> 
> MacOS no longer relies on the nvram setting. Video drivers are free to
> put whatever they want in their own device tree node, and usually store
> an nvram value for the mode there, but this is proprietary and depends on
> the driver. MacOS itself now stores the various infos in a preferences
> file. The old "Monitors" control panel still updates the old pram
> location with a mode value but the meaning is not guaranteed (can be
> driver specific).

Thus I can remove the nvram code from atyfb?

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
