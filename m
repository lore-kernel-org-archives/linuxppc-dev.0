Date: Thu, 4 May 2000 08:11:30 -0700
From: Matt Porter <mmporter@home.com>
To: Adrian Cox <apc@agelectronics.co.uk>
Cc: Gabriel Paubert <paubert@iram.es>, Gong Zhuo_sina <gong_zhuo@sina.com.cn>,
        linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Any compact pci driver for MCP750?
Message-ID: <20000504081130.B3520@cx258813-a.chnd1.az.home.com>
References: <Pine.HPX.4.10.10005041203430.234-100000@gra-ux1.iram.es> <391154B5.1CCDFEF0@agelectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <391154B5.1CCDFEF0@agelectronics.co.uk>; from apc@agelectronics.co.uk on Thu, May 04, 2000 at 11:45:09AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, May 04, 2000 at 11:45:09AM +0100, Adrian Cox wrote:
>
> Gabriel Paubert wrote:
> > For the MCP750, you should have no problems. But to access MCPN750, the
> > code is not written and even the infrastructure is not (yet) there. some
> > more work to support non transparent PCI<->PCI bridges is necessary.
>
> On x86 architecture, Ziatech have CompactNet, which uses the 21554
> non-transparent bridge. This should be portable to PowerPC, though some
> work may be required:
> http://www.compactnet.com/

MontaVista's Hard Hat Net already works on x86 and PowerPC boards
(including the MCPN750).  You can pick it up at
http://www.mvista.com/download/hhnet-1.0-1.src.rpm

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
