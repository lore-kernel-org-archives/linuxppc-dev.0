Message-ID: <40A8FED6.9000809@ru.mvista.com>
Date: Mon, 17 May 2004 22:05:10 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: Gennadiy Kurtsman <gkurtsman@ru.mvista.com>
Subject: [PATCH]  for linuxppc-2.4 tree: 10/100 Ethernet driver for Xilinx
 ML300
References: <4034C37D.20909@ru.mvista.com> <405B2C46.90108@ru.mvista.com>
In-Reply-To: <405B2C46.90108@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Here is the 10/100Mb ethernet driver update for Xilinx EMAC.

New functionality added:
1) SG DMA transfer support;
2) putting more than one packet per interrupt into FIFO (FIFO mode);
3) interrupt coalesce parameters setting using ioctl commands (SGDMA mode);
4) ethtool utility support;
5) bottom half interrupts service.

Fixed:
1) memory deallocation in cleanup function;
2) setting Tx timeout in FIFO mode.

The patch affects Xilinx ML300 board only.

The patch itself can be found here:
http://source.mvista.com/~ank/xilinx_xenet_update.040517.diff

The patch is against the kernel version 2.4.26.

The patch author is Gennadiy Kurtsman.

Best regards,
Andrei Konovalov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
