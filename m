Date: Fri, 16 May 2003 17:04:48 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: Virtex II Pro eval Boards
To: emanuel stiebler <emu@ecubics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <3EC57CA0.F22C2C59@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <3EC568D2.6020905@ecubics.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Emanuel,

Xilinx sells the ML300 board, see http://www.xilinx.com/ml300. The board has a
PMC slot, two PC Card slots and FireWire (behind a PCI bridge). All peripherals

(including the PCI host bridge) are compiled into the FPGA.
MontaVista Linux 3.0 supports the ML300 including PCI, see
http://www.mvista.com/partners/semiconductor/xilinx.html

Our distributors also sell Virtex-II Pro based boards. AFAIK, none of them have

PCI.

- Peter

emanuel stiebler wrote:

> Hi,
> I remember few people out here talking about the VirtexIIPro. What Eval
> Boards did you use ? Experiences ?
>
> Anybody used the VirtexIIPro with a PCI-Bridge ?
>
> cheers & thanks in advance
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
