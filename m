Date: Tue, 19 Jan 1999 13:35:13 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MCLK=100 breaks PowerBook
In-Reply-To: <199901190047.LAA01101@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.03.9901191335040.12688-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 19 Jan 1999, Paul Mackerras wrote:
> Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:
> > On Mon, 18 Jan 1999, Cort Dougan wrote:
> > > 0x0000 0x1fe2 0x0000 0x3fc3
> > 
> > Hmm, this would indicate mclk (GUI engine clock) runs at 8 MHz, and xclk
> > (memory clock) runs at 16 MHz... very slow machine :-)
> 
> 0x1fe2 == 8162, 0x3fc3 == 16323, so mclk = 81.62 MHz surely, not
> 8MHz??

Oops, you're right.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
