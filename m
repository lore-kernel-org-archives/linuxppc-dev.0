Message-ID: <391154B5.1CCDFEF0@agelectronics.co.uk>
Date: Thu, 04 May 2000 11:45:09 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Gong Zhuo_sina <gong_zhuo@sina.com.cn>,
        linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Any compact pci driver for MCP750?
References: <Pine.HPX.4.10.10005041203430.234-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
> For the MCP750, you should have no problems. But to access MCPN750, the
> code is not written and even the infrastructure is not (yet) there. some
> more work to support non transparent PCI<->PCI bridges is necessary.

On x86 architecture, Ziatech have CompactNet, which uses the 21554
non-transparent bridge. This should be portable to PowerPC, though some
work may be required:
http://www.compactnet.com/

I've done some similar work on a PowerPC, but on PCI cards and using a
very different core logic design which avoided the need for a
non-transparent bridge:
http://www.agelectronics.co.uk/tpe3.html
The kernel for this board passes ethernet frames over the PCI backplane
between boards. The novelty over traditional shared memory networking is
the use of I2O units.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
