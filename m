Date: Fri, 24 Mar 2000 14:27:27 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003241335460.7616-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003241423530.21215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > On a somewhat related issue (the PCI mapping funnies for the Lombard and
> > possibly other Rage Pro devices): what are the penalties if I 'correct'
> > the PCI mapping for the Rage Pro within atyfb_of_init?
>
> To be a bit more constructive: what about adapting my patches and use them on
> the Lombard as well? Then the conflicting secondary aperture will be assigned a
> new region, while the valid regions will stay what they are.

Fine with me. I forgot to mention that I'm currently working on the 2.2.15
atyfb source, do your patches apply to that as well? (Frankly, I tried to
follow your argument about the PCI / OF resource handling but couldn't
make out where it would fit in with the problem I try to solve.)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
