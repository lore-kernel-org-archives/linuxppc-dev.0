Subject: PPC750 cPCI Hotplug
From: Matt Dew <mattd@seakr.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1090262208.29910.254.camel@mattd.seakr.com>
Mime-Version: 1.0
Date: Mon, 19 Jul 2004 12:36:48 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
I've searched the archives, the web and every thing else I can think of
to no avail.   I'm hoping someone here might be able to help me out.

I have a Motorola PPC750 with a Raven chipset in a compact PCI test
rack.  I've got the 2.4.19 kernel with the ppc patch applied and it
works very well.

The problem is that I can not get PCI hotplugging to work.

I'm using Xilinx FPGAs on some other boards in the test rack. The FPGAs
have PCI cores but when I configure them after powerup, the kernel does
not see them.  I have hotplug support compiled in the kernel.

I've tried several different kernels, with no luck.

I've noticed there is no CONFIG_HOTPLUG_PCI option for ppc like there is
for other architectures, just CONFIG_HOTPLUG.

Does anyone have hotplug working on a ppc750? Is it even possible?

thanks for any help,
Matt


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
