Date: Wed, 25 Jun 2003 10:24:45 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: Allen Curtis <acurtis@onz.com>
Cc: linuxppc-embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PCI DMA support on the MPC8250
Message-ID: <3EFAF5FC@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>===== Original Message From Allen Curtis <acurtis@onz.com> =====
>>But the DMA transfers are working and are 5 time faster. You must only
program
>>them. It is just 5 registers to configure. You buffers in RAM must be
>>allocated with consistent_alloc to avoid caching on them and you must always
>>write physical addresses in the DMA registers( use virt_to_phys).
>>Note For  PCI addresses virt_to_phys doesn't work well. You must take the
>>addresses from the "remap" function code. I did it and it works very well.
>
>Do you have a patch for you DMA support?

No, but I will make one for the physical address lookup code, the small
changes to support DMA in the kernel (access of EUMBAR base address) and the
snippet of my code that I use in my driver.

It will be against a 2.4.17 Kernel( sorry )

Note : I have A generic DMA driver but it has a big setup time of 25000 cycles
making it interesting (better than memcpy) only for blocks larger than
2KBytes.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
