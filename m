Date: Thu, 11 Mar 1999 15:26:16 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB Reset
In-Reply-To: <19990311141656.017582@mail.mipsys.com>
Message-ID: <Pine.LNX.4.03.9903111524110.7717-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Mar 1999, Benjamin Herrenschmidt wrote:
> There is one advantage of having the mouse and kbd code mixed the way
> they are currently which is to handle the mouse simulation via the kdb
> without exporting all sorts of globals.

Even that can be done cleanly in separate modules: you need to export only one
function in the mouse code to feed button events into the system from the
keyboard code.

Or should the mouse simulation be done in the X server, as is currently already
done to emulate the 3rd button on 2-button mice on PeeCee? A disadvantage of
that is that it has to be done in gpm then, too.

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
