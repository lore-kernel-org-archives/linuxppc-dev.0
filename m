Message-ID: <38DCC9E7.25CF97CE@iiic.ethz.ch>
Date: Sat, 25 Mar 2000 15:15:03 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
References: <Pine.HPX.4.10.10003242053320.14656-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> > But probably X will disable both 0x81000000->0x81ffffff and 0x81800000->
> > 0x81ffffff because they overlap the 0x81fff000->0x81ffffff range. No gain.
>
> Then X needs to be fixed, perhaps the generic X PCI code needs special
> hooks for individual drivers to check whether the configuration is
> acceptable or not.

Sounds a bit drastic to correct a small, isolated problem like this.


> OTOH I don't understand why something there (OF ?) insists in overlapping
> the registers with the VRAM, the PCI code in the kernel (2.3) should give
> the registers a separate area, saving 4kB of MMIO space is completely
> useless.

Right. If it is fixed more reasonably and easily in the kernel, why should it
be worked around in X?


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
