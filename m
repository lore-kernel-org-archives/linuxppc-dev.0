Date: Thu, 10 Dec 1998 11:58:28 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Corey Minyard <minyard@acm.org>, Troy Benjegerdes <hozer@drgw.net>,
        Dan Malek <dmalek@jlc.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
In-Reply-To: <Pine.LNX.3.96.981209224800.20040A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.03.9812101158000.5818-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Dec 1998, Cort Dougan wrote:
> Great!  That's exactly what we need.
> 
> }I would like to make things in the arch/ppc/kernel directory more
> }"polymorphic", meaning I'd like to have a table of function pointers
> }that point to the various procedures to handle things, much like a

And that's what we've been doing on m68k for years
(include/asm-m68k/machdep.h).

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
