Message-Id: <5.2.1.1.0.20030625061628.00ae8170@192.168.1.10>
Date: Wed, 25 Jun 2003 06:17:21 -0700
To: Callebaut Benoit <callebaut@mailandnews.com>,
	rowejames@acmsystems.com
From: Allen Curtis <acurtis@onz.com>
Subject: Re: PCI DMA support on the MPC8250
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3EFFFCC6@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>But the DMA transfers are working and are 5 time faster. You must only program
>them. It is just 5 registers to configure. You buffers in RAM must be
>allocated with consistent_alloc to avoid caching on them and you must always
>write physical addresses in the DMA registers( use virt_to_phys).
>Note For  PCI addresses virt_to_phys doesn't work well. You must take the
>addresses from the "remap" function code. I did it and it works very well.

Do you have a patch for you DMA support?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
