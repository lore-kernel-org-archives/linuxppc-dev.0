Date: Sat, 30 Jan 1999 14:32:32 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
Cc: mlan@cpu.lu, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody?
In-Reply-To: <19990130020006.A580@toocool.calpoly.edu>
Message-Id: <Pine.SGI.4.02A.9901301411250.9620-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> I'm running an x86 Matrox card in my 8600, and it "sort of" works
> right now on 2.2.0.  It appears that there are definitely some kernel

To be honest I haven't tried this. I've been snowed under with work since
October :-(. The last thing I tried was building a 2.2pre6 kernel which
worked o.k. bar breaking my PPP connection. I didn't build the kernel
with matroxfb support though as I thought the less I experiment with the
better.

> bugs as far as mode switching, as sometimes control and matrox end up
> duplicating each other resulting in very funky displays.  I had to hack

This doesn't sound good. What exactly are you doing to achieve this?

> the kernel slightly, in that it assumes if you have a Mac, well then you
> must have a Mac matrox card, and OF should take care of initialization.
> Nope, I've got a x86 card, and it has to be initialized by the kernel.
> Simple one line hack in the init function for matroxfb.  

o.k. as far as I know Petr set things up so that under a Mac the card was
always initialised by OF - even for x86 cards (like my mystique and your
mil. I). The change is listed in Petr's readme/changes file. Petr can you
comment on this?

What I'll do is bring my kernel sources up to 2.2.0-final and try setting
up my Mystique again. Then let you know what happens.

On a realted note though, has anybody got a matrox card running under
pre-R5 with the XFree86, framebuffer stuff running? I'm still running R4
but once R5 is out I'll move over to XFree from XPmac.

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
