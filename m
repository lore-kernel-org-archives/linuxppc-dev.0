In-Reply-To: <Pine.GSO.4.10.10003240958290.7616-100000@dandelion.sonytel.be>
Date: Fri, 24 Mar 2000 10:54:31 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000324105431.025518@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 24, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:


>Another advantage of no longer using the information from the OF tree is that
>we can just call pci_assign_unassigned_resources() and get everything
>reassigned, without worrying about inconsistencies with the OF device tree.
>
>BTW, if you do want to keep the OF device tree consistent,
>pcibios_update_resource() is the place to do this.

If this is called _after_ we have done the bus re-numbering, updating the
OF tree will be difficult since we need the old bus number to match the
PCI device with it's OF entry.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
