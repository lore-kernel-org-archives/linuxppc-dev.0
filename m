Message-ID: <3C3C8091.8070300@humboldt.co.uk>
Date: Wed, 09 Jan 2002 17:40:33 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ISA DMA take 2
References: <0201091721.AA22295@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:


> What's your memory map? Do you put the bottom 16 MB of main memory in the
> bottom 16 MB of the PCI memory space on the PCI segment with the Via without an
> I/O hole?

Yes - and I set ISA_DMA_THRESHOLD to 0x00ffffff. It's not possible to
use ISA DMA with the Via southbridge unless you have main memory at 0x0
on the PCI bus.

Of course, if anybody knows a cheap southbridge with 32-bit ISA DMA,
UDMA100, and maybe USB, it would be nice to hear of it for future boards.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
