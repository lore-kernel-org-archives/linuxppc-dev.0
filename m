Message-ID: <3D77BAF7.CBFFB809@xilinx.com>
Date: Thu, 05 Sep 2002 13:13:43 -0700
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: "Peter 'p2' De Schrijver" <p2@mind.be>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Xilinx TFT interface driver
References: <20020904195856.GJ781@mind.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter,

all the devices for which you posted patches are supported in the
linuxppc_2_4_devel tree for more than a month. The tree contains device
drivers/support for the following Xilinx devices

- Interrupt Controller
- 10/100 Mbit Ethernet
- PS2 port (mouse/keyboard)
- Uart (actually, the standare Linux Uart driver)
- TFT
- GPIO
- IIC

More drivers will be added soon.

- Peter


Peter 'p2' De Schrijver wrote:

> Hi,
>
> Attached you will find a patch implementing a Linux framebuffer driver
> for the Xilinx TFT interface. It was tested on a Xilinx Virtex2Pro
> implementation.
>
> Comments welcome,
>
> Peter.
>
>   ------------------------------------------------------------------------
>
>    xtft-patchName: xtft-patch
>              Type: Plain Text (text/plain)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
