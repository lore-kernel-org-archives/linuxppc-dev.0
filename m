Date: Mon, 1 Feb 1999 17:25:54 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <19990201165538.009774@mail.mipsys.com>
Message-ID: <Pine.LNX.4.03.9902011723560.17350-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Benjamin Herrenschmidt wrote:
> On Mon, Feb 1, 1999, Geert Uytterhoeven
> <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:
> 
> >Since BootX creates a fake OF device tree, I suspect it to appear in the
> tree.
> >Can you use your Mystique under MacOS? This is of course a prerequisite for
> >BootX seeing your board.
> 
> OF in the machine's ROM (not the card's ROM) should make _any_ PCI board
> visible provided that it contains correct config-space registers with a
> vendorID and a deviceID, which is required for all PCI cards anyway. The

I'd expect that, too. But my DawiControl DC-2976UW Sym875 SCSI board doesn't
show up in /pci, while my S3 Vision968 is visible as /pci/display. Both boards
don't have OF ROMs.

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
