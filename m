Date: Sat, 28 Aug 1999 13:58:49 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "David D. Kilzer" <ddkilzer@computer.org>
cc: linuxppc-dev@lists.linuxppc.org,
        Linux/mac68k List <linux-mac68k@mac.linux-m68k.org>,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: mac-2.3.14.diff: adb
In-Reply-To: <v0313030db3ece7c8caa1@[192.168.1.1]>
Message-ID: <Pine.LNX.4.10.9908281358000.8134-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 27 Aug 1999, David D. Kilzer wrote:
> Jes doesn't want to patch anything into drivers/macintosh.  He believes
> that ADB code should be split into the bus code (drivers/adb) and into
> device code (drivers/char/adb or drivers/char) and that drivers/macintosh
> should go away.
> 
> I'm afraid that the m68k stuff is going to appear in drivers/[char/]adb
> while the PPC stuff is going to remain in drivers/macintosh, and we'll be
> worse off than we were before the merge!
> 
> Do we need to raise this issue on linux-kernel to get it resolved,
> especially since the NeXT port (another m68k-based system) uses ADB as well?

Hence ADB bus stuff must be moved to drivers/adb/.

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
