Mime-Version: 1.0
Message-Id: <v04220800b664cfa8ae01@[10.0.0.42]>
In-Reply-To: <200012190700.IAA00759@piglet.grunz.lu>
References: <200012190700.IAA00759@piglet.grunz.lu>
Date: Tue, 19 Dec 2000 00:49:43 -0800
To: mlan@cpu.lu, berke@kis.uni-freiburg.de
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PCI-to-parallel port problem
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:00 AM +0100 12/19/00, Michel Lanners wrote:
>On  18 Dec, this message from Thomas Berkefeld echoed through cyberspace:
>>  I have FASTPCI 4008 PCI parallel port card from Dolphin Peripherals. To
>>  use the card,
>>  the manual tells to modprobe parport_pc.o with io-address and irq.
>>  Unfortunatley
>>  parport_pc.c cannot be compiled with
>>  kernel 2.4.0-test11 on my G4 Mac  (a header is missing).
>>  Furthermore /proc/pci says the interrupt number is 53 which seems a bit
>>  high.
>
>Depends. PowerMacs have at least 32 interrupts, but some have more.
>Anybody know for sure on the G4?

It's 64 on Uni-N based Macs, which includes most G4s, because they
use an OpenPIC interrupt controller:

...
PowerMac using OpenPIC irq controller
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at efe2d000
...


There are a few "Yikes!" G4 machines which use the same motherboard
as the B&W G3.  The interrupt controller in these also supports 64
IRQ sources.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
