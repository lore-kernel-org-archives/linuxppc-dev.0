Message-ID: <B895EFF5AF34724880036BDB5B5B8148135648@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Peter Ryser'" <Peter.Ryser@xilinx.com>,
	emanuel stiebler <emu@ecubics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Virtex II Pro eval Boards
Date: Fri, 16 May 2003 17:11:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Clarification:  Ours uses PCI as an FPGA configuration option.

-----Original Message-----
From: Peter Ryser [mailto:Peter.Ryser@xilinx.com]
Sent: Friday, May 16, 2003 5:05 PM
To: emanuel stiebler
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Virtex II Pro eval Boards



Emanuel,

Xilinx sells the ML300 board, see http://www.xilinx.com/ml300. The board has
a
PMC slot, two PC Card slots and FireWire (behind a PCI bridge). All
peripherals

(including the PCI host bridge) are compiled into the FPGA.
MontaVista Linux 3.0 supports the ML300 including PCI, see
http://www.mvista.com/partners/semiconductor/xilinx.html

Our distributors also sell Virtex-II Pro based boards. AFAIK, none of them
have

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
