From: Benjamin Herrenschmidt <bh40@calva.net>
To: Thomas Graichen <graichen@innominate.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IDE-DMA check
Date: Sun, 27 Aug 2000 12:33:14 +0200
Message-Id: <20000827103314.5822@192.168.1.10>
In-Reply-To: <news2mail-8oaihl$tra$1@mate.bln.innominate.de>
References: <news2mail-8oaihl$tra$1@mate.bln.innominate.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>i always get the following on the 2.4.0-test kernels:
>
>ide0 at 0xcd8e7000-0xcd8e7007,0xcd8e7160 on irq 19
>IDE-DMA check !
>hda: 13379310 sectors (6850 MB) w/418KiB Cache, CHS=14158/15/63
>IDE-DMA check !
>hdb: ATAPI 24X CD-ROM drive, 128kB Cache
>
>and it does not automatically set ide-dma although i enabled the
>auto dma setting in the kernel config - what exactly does this
>mean?
>
>a lot of thanks in advance

This had been fixed one or two weeks ago in the bitkeeper tree. The fix
should be in Linus tree soon.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
