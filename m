Date: Fri, 24 Mar 2000 13:37:01 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241142540.18758-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003241335460.7616-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:
> > >Another advantage of no longer using the information from the OF tree is that
> > >we can just call pci_assign_unassigned_resources() and get everything
> > >reassigned, without worrying about inconsistencies with the OF device tree.
> > >
> > >BTW, if you do want to keep the OF device tree consistent,
> > >pcibios_update_resource() is the place to do this.
> >
> > If this is called _after_ we have done the bus re-numbering, updating the
> > OF tree will be difficult since we need the old bus number to match the
> > PCI device with it's OF entry.
>
> On a somewhat related issue (the PCI mapping funnies for the Lombard and
> possibly other Rage Pro devices): what are the penalties if I 'correct'
> the PCI mapping for the Rage Pro within atyfb_of_init?

To be a bit more constructive: what about adapting my patches and use them on
the Lombard as well? Then the conflicting secondary aperture will be assigned a
new region, while the valid regions will stay what they are.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
