Message-ID: <3F723C33.9030003@mvista.com>
Date: Wed, 24 Sep 2003 17:52:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: =?x-windows-949?B?vcWw5rz2?= <ksshin@essetel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI DMA in GT64260
References: <009501c37dba$0f462470$c50aa8c0@ksshin>
In-Reply-To: <009501c37dba$0f462470$c50aa8c0@ksshin>
Content-Type: text/plain; charset=x-windows-949
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well there are a lot of things that could be wrong. I'd have to actually
see your code to figure out what's wrong. Use
arch/ppc/platforms/ev64260.c as an example, if you haven't already.
Sorry I can't help more but there are simply too many possibilities and
not enough info to narrow down the possibilities to suggest anything.

Mark
--

½Å°æ¼ö wrote:

>Dear all.
>
>I have a board that consisted of mpc7410+gt64260+pci_device,
>and I have already success to read/write the pci_device.
>After init the pci_device, I command to the pci_device
>that read data from main memory(sdram),
>but, the pci_device does not operate and return only fail...
>
>I think that this is the DMA Problem...
>so I want to know that how to set the register of gt64260 to do
>DMA operation.
>
>I already set PCI SCS[0] Size Reg, PCI SCS[0] Base Addr Remap Reg,
>and PCI Base Address Enable Reg. what I omitted? or ...
>
>please help me...
>
>Thanks everybody.
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
