From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@lists.linuxppc.org,
	linux-galileo@source.mvista.com
Subject: Pci issues
Date: Thu, 17 Jul 2003 09:34:33 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200307170934.34084.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi all,
I am using a DB64360 with a single 7455 processor and  I am having a problem
that is driving me nuts. I have a PCI card that contains a P2P bridge and an
serial bus controller behind it. I am trying to use it under Linux and I
can't seem to get the required resources. I have this card working under an
ev64260 though. The serial bus controller requires 3 regions:
BAR 0: 1 MB non-prefetchable
BAR 2: 2 MB non-prefetchable
BAR 4: 64 MB prefetchable.

I use u-boot as my bootloader (although Dink 32 gives me the same problems
under Linux) because I am a bit more familiar with the code. I get error
message when the kernel scans the bus saying:

PCI: Cannot allocate resource region 1 of PCI bridge 2
PCI: Cannot allocate resource region 2 of PCI bridge 2
PCI: bridge 2 resource 2 moved to 9ff00000..9fffffff
PCI: Cannot allocate resource region 0 of device 02:00.0
PCI: Cannot allocate resource region 2 of device 02:00.0
PCI: Cannot allocate resource region 4 of device 02:00.0
PCI: Failed to allocate resource 0(0-fffff) for 02:00.0
PCI: Failed to allocate resource 2(a0000000-9fffffff) for 02:00.0
PCI: Failed to allocate resource 4(a0000000-9fffffff) for 02:00.0

Any ideas why this may be? I am really at a loss and I was hoping for a bit of
insight. I am attaching the complete log from u-boot to Linux including an
lspci ouput at the end. As for hardware, I am using a DB64360 with 7455 at
931 Mhz. The Discovery II part is a rev A2. The kernel is
2.4.21-pre7 from the _devel tree, along with your most recent work from the
_galileo tree. Everything else is working well but this card is giving me
huge troubles. Any help would be greatly appreciated!

Thank You
Brian Waite


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
