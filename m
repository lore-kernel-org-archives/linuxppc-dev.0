Date: Mon, 18 Jan 1999 18:04:39 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MCLK=100 breaks PowerBook
In-Reply-To: <Pine.LNX.3.96.990118095104.18478A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.03.9901181803180.339-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 18 Jan 1999, Cort Dougan wrote:
> 0x0000 0x1fe2 0x0000 0x3fc3
> 
> }If you convert these to decimal, you get `6712', i.e. a mclk of 67 MHz.
> }Cort: what are the `MCLK,XCLK' properties for your PowerBook?

Hmm, this would indicate mclk (GUI engine clock) runs at 8 MHz, and xclk
(memory clock) runs at 16 MHz... very slow machine :-)

BTW, on most ATI chips mclk and xclk run at the same speed.

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
