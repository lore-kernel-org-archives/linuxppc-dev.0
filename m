Date: Thu, 15 Jul 1999 10:36:43 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Michael R. Zucca" <mrz5149@acm.org>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Minor atyfb problems/observations
In-Reply-To: <l03130301b3b2ec750e23@[216.67.46.46]>
Message-ID: <Pine.LNX.4.10.9907151033260.15826-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Jul 1999, Michael R. Zucca wrote:
> Ok, with the latest fifo patch in place I no-longer get the flickering
> pixels on the left side of my screen. However, I think there's another
> problem which may not be X-Server related.
> 
> I use the drag-style for windows which draws an outline of the window
> rather than a solid window.
> When I do this I get a sort of flickering of black down the left side when
> I'm dragging the window
> around. What could be the cause of that problem?

The FIFO again.

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
