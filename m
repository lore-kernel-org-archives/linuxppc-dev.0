From: luca.gambazzi@epfl.ch
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel 2.4 on Force Computers 3750
Message-ID: <1054648568.3edca8f806f4b@imapwww.epfl.ch>
Date: Tue, 03 Jun 2003 15:56:08 +0200 (MEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello

i'm using kernel 2.5 from the powerpc tree (penguinppc) on my  Force Computers
cpci 3750. For the 2.5 kernel the only problem was the IRQ number in
arch/ppc/platforms/pcore_pci.c:48 (in the old 3750 is 9 and not 10),... and
worked fine.

On this system i've got differents cpci cards, and drivers for INOVCA cpci multi
exist only for 2.4 kernels (comedi.org). So i've used the linux_2_4_devel tree.
But the system doesn't boot, it stops after "Now booting the kernel" (console
parameters are correct). So i've tried an old 2.4.7 downloadable from
www.timesys.com (another version of pcore patch). It boot but with this output

[...]
PCI: Probing PCI hardware
PCI:00:19.0 Resource 1 [fffffc00-ffffffff] is unassigned
Fixup res 6 (7200) of dev 00:19.0: ffd80000 -> fcd80000
Memory resource not set for host bridge 0
Fixup res 0 (1208) of dev 01:0d.0: 80000000 -> 7d000000
Fixup res 0 (200) of dev 01:0e.0: 80001000 -> 7d001000
Fixup res 2 (200) of dev 01:0e.0: 84000000 -> 81000000
Fixup res 0 (200) of dev 01:0f.0: 88000000 -> 85000000
Fixup res 1 (200) of dev 01:0f.0: 88010000 -> 85010000
Fixup res 2 (200) of dev 01:0f.0: 88030000 -> 85030000
PCI: Unable to handle 64-bit address space for
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: resource is 7d000000..8cffffff (200), parent 00000000
PCI:00:19.0: Resource 0: 00850000-0085007f (f=101)
PCI:01:0d.0: Resource 0: 7d000000-7d000fff (f=1208)
PCI:01:0e.0: Resource 0: 7d001000-7d0010ff (f=200)
PCI:01:0e.0: Resource 1: 008a0000-008a00ff (f=101)
PCI:01:0e.0: Resource 2: 81000000-84ffffff (f=200)
PCI:01:0f.0: Resource 0: 85000000-85000fff (f=200)
PCI:01:0f.0: Resource 1: 85010000-8501ffff (f=200)
PCI:01:0f.0: Resource 2: 85030000-8503ffff (f=200)
PCI:00:1e.1: Resource 0: 000001f0-000001f7 (f=101)
PCI:00:1e.1: Resource 1: 000003f4-000003f7 (f=105)
PCI:00:1e.1: Resource 2: 00000170-00000177 (f=101)
PCI:00:1e.1: Resource 3: 00000374-00000377 (f=105)
  got res[fd000000:fd0003ff] for resource 1 of Digital Equipment Corporation DE3
  got res[1000:100f] for resource 4 of Symphony Labs SL82c105
  got res[1010:101f] for resource 5 of Symphony Labs SL82c105
[...]

Sombebody have experience with this kind of problems?
(knows how to resolve this problem with 2.4.7-timesys or how to boot the lastest
  2.4 ppc dev release)

thanks a lot
luca


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
