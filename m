Date: Wed, 9 Jan 02 09:21:19 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0201091721.AA22295@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ISA DMA take 2
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox <adrian@humboldt.co.uk> wrote:

> Attached is an update to my ISA DMA patch. The main change from the
> previous patch is that it works, because it now changes MAX_DMA_ADDRESS.
> I've tested it on my platform (Via 686 southbridge, ISA DMA for floppy),
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> and it shouldn't break any others.

What's your memory map? Do you put the bottom 16 MB of main memory in the
bottom 16 MB of the PCI memory space on the PCI segment with the Via without an
I/O hole?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
