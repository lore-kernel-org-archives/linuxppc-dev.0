From: bob@kunk.jriver.com
Message-ID: <20010315193345.17142.qmail@kunk.jriver.com>
Subject: Multiple PCI buses in 2.4?
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 15 Mar 2001 13:33:45 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm wondering what the state of support for multiple pci buses on
PowerMacs is in 2.4? I see by looking at the code and reading the
lists that work is being done on it since 2.4.1.

The 7X00/8X00 has 2 bridge devices both of which are recognized by
2.42 in the  boot messages but an lspci only shows one bus.

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 21)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8029(AS)
00:0f.0 Communication controller: Comtrol Corporation RocketPort 8 Intf (rev 02)00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)

The planb video4linux device is on the other bus and upon attempting to
load the planb module I get the following...

Linux video capture interface: v1.00
PlanB: Found on bus 1, dev 13, func 0, membase 0x90000000 (base reg. 0x10)
PlanB: cannot find PCI device!

The call that fails...

pdev = pci_find_slot (bus, dev_fn);

I've worked most recently with the 2_5 kernel from bitkeeper.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
