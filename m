Date: Tue, 12 Jan 1999 21:57:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Paul Mackerras <paulus@cs.anu.edu.au>, Dan Malek <dmalek@jlc.net>,
        bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: new irq.c
In-Reply-To: <Pine.LNX.3.96.990111182245.1184A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.03.9901122155550.26849-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 11 Jan 1999, Cort Dougan wrote:
> I've tested it pretty well.  You guys want to check it out for me?
> Comments?
> 
> I haven't finished cleaning up the chrp stuff yet.

| irq.c: In function `gatwick_action':
| irq.c:653: gatwick_action causes a section type conflict
| irq.c: In function `pmac_set_irq_mask':
| irq.c:704: pmac_set_irq_mask causes a section type conflict

Ugh?

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
