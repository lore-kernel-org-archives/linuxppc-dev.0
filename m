Date: Tue, 2 Feb 1999 14:10:49 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <Pine.LNX.4.03.9902011723560.17350-100000@mercator.cs.kuleuven.ac.be>
Message-Id: <Pine.SGI.4.02A.9902021408200.13845-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Geert Uytterhoeven wrote:
 
> On Mon, 1 Feb 1999, Benjamin Herrenschmidt wrote:
> > On Mon, Feb 1, 1999, Geert Uytterhoeven
> > <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:
> > >Since BootX creates a fake OF device tree, I suspect it to appear in the
> > tree.
> > >Can you use your Mystique under MacOS? This is of course a prerequisite for
> > >BootX seeing your board.
> > OF in the machine's ROM (not the card's ROM) should make _any_ PCI board
> > visible provided that it contains correct config-space registers with a
> > vendorID and a deviceID, which is required for all PCI cards anyway. The
> I'd expect that, too. But my DawiControl DC-2976UW Sym875 SCSI board doesn't
> show up in /pci, while my S3 Vision968 is visible as /pci/display. Both boards
> don't have OF ROMs.

Geert, do either of these cards show up under your OF tree? I wouldn't
expect so as theyt don't have an OF rom (like my mystique) but I am
curious.

Cheers

-------------------------------------------------------------------------
Owen Waller                     |   "...sometimes I think I'm a little
PhD. Student in Control Eng.    |    more English than I am French..."
Queens University               |              - Alain Prost 
Belfast                         |
Tele: +44 (0)1232 274085        |    Fax: +44 (0)1232 667023


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
