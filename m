Message-ID: <38DF2D3E.2E5B19E7@iiic.ethz.ch>
Date: Mon, 27 Mar 2000 11:43:26 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
References: <Pine.LNX.4.10.10003271050560.31313-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
> one solves my PCI address conflict for the Mach64 by reallocating the MMIO
> aperture, and allows XFree86 4.0 to run on my Lombard.

Great news! So how does it compare to 3.3.x for you?


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
