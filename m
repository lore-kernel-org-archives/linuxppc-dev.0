Date: Mon, 23 Feb 2004 11:28:07 -0800
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: Xilinx ML300 PCI
In-reply-to: <20040221235307.56947.qmail@web11610.mail.yahoo.com>
To: Shamile Khan <shamile@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <403A5447.4020702@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20040221235307.56947.qmail@web11610.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shamile,

current kernels support the PCI core that shipped with V2PDK. The PCI
core that ships with EDK is slightly different and we are working on the
necessary software modifications to upgrade the kernel sources. ETA is
unknown.

- Peter


Shamile Khan wrote:

>Hi,
>
>Our custom board utilizes Xilinx's PCI Core inside the
>Virtex II chip. I looked at the kernel sources in
>linuxppc_2_4_devel tree and I see support for PCI. Is this
>support for Xilinx PCI core or an external PCI chip.
>
>Thanks,
>Shamile
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
