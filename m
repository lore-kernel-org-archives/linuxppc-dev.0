Message-ID: <40B4AB27.5020202@fh-landshut.de>
Date: Wed, 26 May 2004 16:35:19 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ioremap() question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I start with a CPU physical address somwhere within the PCI bridge space: 0x85000000
Then I use ioremap_nocache on it to obtain a (range of) virtual address(es):
0xC302D000
And then I use virt_to_bus() to obtain an address to hand over to the PCI device:
0x0302D000


While I do see this conforms to the implementation of virt_to_bus(), I cannot
decide whether this makes sense.

Is ioremap() fixed, so it always returns the same virtual addresses for the same
given physical ones?

Or does it return "what's available" in virtual address space (so the above bus
address would be somehow bogus I guess)?

Would a function like phys_to_bus() give me the same result?

Thanks in advance,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
