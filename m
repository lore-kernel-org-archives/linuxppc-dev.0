Date: Fri, 24 Mar 2000 18:51:15 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241806210.22814-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.HPX.4.10.10003241848330.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:

> They are prioritized the right way: if you memset the whole aperture to 0
> the chip freaks out instead of just painting the whole screen black. Been
> there, done that.

Ok, anyway memsetting the whole aperture may not be the smartest thing to
do since the aperture may be larger than the installed VRAM.

> Well, arguing with X is pointless. So far I've always got the short end of
> the stick :-)

Hmmm, then find some free space and put the MMIO registers in this area.

> I mean: if someone disables the original resource, what happens to the
> new resources?

I don't understand the question.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
