Date: Wed, 9 Jan 02 09:53:06 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0201091753.AA22414@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ISA DMA take 2
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox <adrian@humboldt.co.uk> wrote:

> Yes - and I set ISA_DMA_THRESHOLD to 0x00ffffff. It's not possible to
> use ISA DMA with the Via southbridge unless you have main memory at 0x0
> on the PCI bus.

As I understand it, you also have to have no I/O hole in the mapping of the
bottom 16 MB of memory onto PCI, right? As I understand it, Linux/PPC is a sane
PPC OS and treats all PPC memory as normal, without any special treatment for
0xA0000-0xFFFFF, so your DMA buffer could legitimately end up in that region
and if your memory map has an I/O hole you would be screwed, right? And of
course main memory on PCI at 0 with no I/O hole means you can't have video on
the same PCI bus... !@#$ing pee sea legacy :(

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
