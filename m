Message-ID: <3BC7388E.CEBF1416@carts.com>
Date: Fri, 12 Oct 2001 11:38:06 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: PCI support
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to setup a PCI bridge on our 8260 board here, and was
wondering if a driver exists for the Tundra Powerspan. We're using Hard
Hat Linux 2.0 JE

If I write my own drivers, where would the board-specific PCI routines
go in the kernel code? I found the function prototypes in linux/pci.h,
but couldn't find any pci code itself.  Does HHL 2.0 JE support PCI?

Thanks!
Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
