Date: Mon, 16 Oct 2000 09:53:06 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Matt Porter <mporter@mvista.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 kernel doesn't allocate resource for my PCI Board
In-Reply-To: <20001013091904.B24968@beef.az.mvista.com>
Message-ID: <Pine.LNX.4.21.0010160948000.1915-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Fri, 13 Oct 2000, Matt Porter wrote:
> Standard 2.4 PCI resource handling problems.  #define DEBUG in
> arch/ppc/kernel/pci.c and show us your output.  The request_resource()
> call is failing.
>
Here's the result (PCI part) :
PCI: Probing PCI hardware
Setting PCI interrupts for a "MVME 2300"
Relocating PCI address 3c000000 -> 1000000
Relocating PCI address 2ffef000 -> 1fef000
Relocating PCI address 2ffeef80 -> 1feef80
Relocating PCI address 2ffeee00 -> 1feee00
Relocating PCI address 2ffed000 -> 1fed000
PCI: Resource 01000000-3c03ffff (f=200, d=0, p=0)
PCI: Resource 0ffffff0-0ffffff7 (f=101, d=0, p=0)
PCI: Resource 0fffffec-0fffffef (f=10d, d=0, p=0)
PCI: Resource 0fffffe0-0fffffe7 (f=101, d=0, p=0)
PCI: Resource 0fffffdc-0fffffdf (f=10d, d=0, p=0)
PCI: Resource 0fffffc0-0fffffcf (f=101, d=0, p=0)
PCI: Resource 0fffffb0-0fffffbf (f=101, d=0, p=0)
PCI: Resource 01fef000-2ffeffff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 0 of device 00:0d.0
PCI: Resource 0fffe000-0fffefff (f=101, d=0, p=0)
PCI: Resource 0fffdf80-0fffdfff (f=101, d=0, p=0)
PCI: Resource 01feef80-2ffeefff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 1 of device 00:0e.0
PCI: Resource 0fffde00-0fffdeff (f=101, d=0, p=0)
PCI: Resource 01feee00-2ffeeeff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 1 of device 00:11.0
PCI: Resource 01fed000-2ffedfff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 2 of device 00:11.0
PCI: Failed to allocate resource 2 for Symbios Logic Inc. (formerly
NCR) 53c895

Hope it will help...

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
