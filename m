Message-ID: <20040310234754.50442.qmail@web11608.mail.yahoo.com>
Date: Wed, 10 Mar 2004 15:47:54 -0800 (PST)
From: Shamile Khan <shamile@yahoo.com>
Subject: Xilinx PLB UART
To: linuxppc-embedded@lists.linuxppc.org
Cc: peter.ryser@xilinx.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

This question concerns Xilinx Virtex II Pro platform. We
have been using OPB UART for Linux. We just tried to switch
from OPB UART to PLB UART. We have interrupts enabled. So
the kernel boots till

Freeing unused kernel memory: 40k init

At this point, I dont see anything on the screen. I dont
even see the slow display of characters on the screen
implying that the kernel has switched to polling mode. I
didnt change anything for the kernel as I expected the OPB
UART functionality to be identical to PLB UART from
processor's perspective. Are you aware of any issues
concerning PLB UART for Linux?

Thanks,
Shamile


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
