Date: Sun, 31 Jan 1999 15:36:27 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
cc: Owen Waller <O.Waller@ee.qub.ac.uk>, mlan@cpu.lu,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <19990130153420.A970@toocool.calpoly.edu>
Message-ID: <Pine.LNX.4.02.9901311514420.2341-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 30 Jan 1999, dhiltgen@toocool.calpoly.edu wrote:
> It appears that the issue is that somehow the kernel is using fb0
> sometimes, and others it's using FRAMEBUFFER, or the "-fb" argument.
> When I try to change settings using fbset it's like both frame buffers
> get set at once, and one of them gets confused since the timings are only
> valid for one of the cards.  ...or, the FB code in the kernel _really_
> isn't very clean when it comes to multiple heads right now, and some
> code just assumes /dev/fb0 is console and uses it without checking for
> the proper state information.  I guess the whole thing is complicated 
> by the fact that sometimes it's user space stuff, other times it's kernel 
> space stuff messing with the fb.

There are known problems with multiheadness. Unfortunately I can't `see' what's
wrong until I get my second video board working. Yes, I'm embarassed by that.

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
