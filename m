Date: Thu, 1 Jun 2000 16:11:21 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Mark Morrill <mmorrill@powersurfr.com>
cc: LinuxPPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IBM PowerPC - Linux Connections?
In-Reply-To: <B55ABC54.71C6%mmorrill@powersurfr.com>
Message-ID: <Pine.BSF.4.21.0006011338270.61502-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 31 May 2000, Mark Morrill wrote:

> on 5/31/00 02:21, Geir Frode Raanes at geirfrs@invalid.ed.ntnu.no wrote:
>
> I know I'm not really looking for an embedded system.  I suppose I really
> should be looking in the Intel world - there it seems so easy to build a
> box.

Seem is the word. That is before things fall apart on you.
Before curious behaviour sets in, before closed source device
drivers drive you nuts and - argh - you have to deal with MS.
And so forth. But I do not want to talk about that.
Let me suggest possible solutions for you instead.

> I brought my questions to the embedded list in the hope that I could get
> leads to a kit that would allow me to prototype a system with off the shelf
> components.  I've got a bit of the software research already happening on a
> Lombard running LinuxPPC.  But I don't think I could take the PowerBook to a
> manufacturer and say, "Make one of these, please"!  :)

But you could. In fact (more on this below) I believe that is
your best option, depending on the cost sensitivity of your
market segment. You buy machines OEM from apple, throw in the
PCI cards you bought OEM from others and sell this as a complete
package. Has been done before and will be done again. But beware
of the "golden screwdriver" reputation.

Then again you can buy embedded building blocks. For instance
PPMC boards from Motorola. PMC is just PCI on fancy high-density
connectors. This you could plug into a passive PCI backplane and
in this backplane plug the PCI boards of your choise. But this
requires an HW engineer to do as PCI is a transmission line and not
just a set of wires. Or you could hire a HW engineer to integrate
the IBM 405GP onto the backplane - AFAIK it does have system slot
capabilities. But be prepared to dig deep into your wallet.
Embedded systems are expensive to design but cheap to manufacute.

BTW, Edge connectors are loved in the US because of their low
cost and hated in Europe because of their low quaility. This is
something you have to take into consideration depending on
the intended (mechanical) use of your product. This is why you
will not find any embedded building blocks with plain vanilla
PCI connectors on it. But if the "embedded" stamp is of no
consern then Motorola Computer Group market ATX conforming
motherboards with PowerPC on it. This is a PC-in-disguise
just like the "Open" architecture of IBM. Be prepared to
have fun with 8259 interrupt controllers and the like.

If only Motorola could take that ATX board and throw out the
ISA bridge and everything that goes with it including IDE, leaving
only PCI slots, then even I would be interested. PowerPC does not
have legacy software dependance on legacy HW so why cludge things
up with this PC heritage? [Spesification: No 8259, no 8237,
no 8047, no 8051, no 8250, no MC146818, no nothing with a
ISA IO register associated with it. Especially not 8259.]

> > As to your idea of what it takes to to ready a system for
> > production... Could we take that in private mail exchange?
>
> That would be great!  I've got lots of software experience but mostly on the
> Mac.  So you can imagine how hardware illiterate I am!  :)

I could elaborate if you drop me a mail asking for it.

But the short form is that sending a piece of hardware out on the
market is not like distributing shareware. You can not write off
all liabilities in the form of a break-this-seal-and-agree-to-
this-no-responsibility-license. First of all you must comply to
all government required standards, including the mother of
all standards - Electro Magnetic Compliance, EMC. (If you
intend to market it in Europe that is. But it is just a question
of time before these rules or similar apply to US too.)

The moment you put that CE mark (and I am not talking about
Chinese Exports) on your box, your ass is in there with it.
If it does kill your customer's cat, you are going to loose
that ass.

Or better still, your product disturbs your customers pacemaker.
Only then you can comfort yourself with the fact that the
manufacturer of the pacemaker will loose more than just his ass
since they should not only comply to EMC but in addition comply
to true paranoia medical equipment standards.

Bottom line - you seem to be far out of touch with the reality of
what we are dealing with here. I guess a MBA could elaborate even
more on the foolhardiness of your crusade from a market point of
view. But then again - if every starter-up knew what he or her
were getting into there would be no starter-ups. Anything
is doable, it just takes time. Lots of time. And money.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
