Date: Wed, 31 May 2000 10:21:19 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Mark Morrill <mmorrill@powersurfr.com>
cc: LinuxPPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IBM PowerPC - Linux Connections?
In-Reply-To: <B55960B7.706C%mmorrill@powersurfr.com>
Message-ID: <Pine.BSF.4.21.0005310930470.52906-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 30 May 2000, Mark Morrill wrote:

>
> on 5/30/00 01:51, Geir Frode Raanes at geirfrs@invalid.ed.ntnu.no wrote:
> > On Mon, 29 May 2000, Mark Morrill wrote:
> >> http://www.chips.ibm.com/products/powerpc/linux/
> >> [snip]
> >
> > Which one - the IBM 405GP Evaluation Kit [hint] or the
> > PC-in-disguise; PowerPC Open Platform reference design?
>
> Ok, do I call IBM to get my hands on the IBM 405GP Evaluation Kit?

Yes.
And IBM will probabely point you to their local electronic
components distributor, which in turn will sell it to you.

> If so where do I start?

Whith what? The Kit or with Embedded-Linux?
The Kit is selfcontained and works out of the box.
It will come with some sort of ROM monitor SW which will set
up most SW configurable options on the board - something like
the PC BIOS, only this thing is actually useful for something.

> I was thinking that the PC-in-disguise was a good option for me...
> But you don't seem to hold it in great favor...

I am a HW engineer. I did not join up on this list to bash the
PC architecture, though that is all I have been able to do so far.
(Just when I thought I was out, they drag me back in...)

I could give you a register-by-register declaration as to why
the (legacy) PC is no good. But that would take quite awhile.

> What I want is a very basic PowerPC computer (ethernet, harddrive, power,
> ram, etc) that'll run Linux that I can prototype a system on and attach a
> couple of PCI cards to.  And when I get my system running, I can take the
> box to a manufacturer for production :)

There are many defenitions of "embedded." One of my favorites is
the negation form "not a workstation." You do not speak of an
embedded system. Most embedded systems do not have expansion
slots even if they do use the PCI bus. Some systems, like those
targeted for telecom do have slots, but these slots are of
industrial quality like VME or CompactPCI.

When we say embedded we mean the kind of things that control your
toaster - and thus can fit into a toaster. We are not speaking of
full desktop systems squeezed into a mini-ATX box. Please adjust
your consept of scale. Harddrives have movable parts inside and
are as such not popular in the embedded world.

As to your idea of what it takes to to ready a system for
production... Could we take that in private mail exchange?

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
