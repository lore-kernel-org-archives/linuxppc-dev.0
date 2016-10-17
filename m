Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3syPnb2MXgzDvJn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 04:09:22 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <alistair@popple.id.au>,
 <mporter@kernel.crashing.org>
CC: <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
 <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>, <paulus@samba.org>,
 <benh@kernel.crashing.org>
Subject: [Patch v5 09/12] MIPS: xilfpga: Update DT node and specify uart irq
Date: Mon, 17 Oct 2016 17:52:53 +0100
Message-ID: <1476723176-39891-10-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the DT node with the UART irq

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V3 -> V4
No change

V2 -> V3
No change

V1 -> V2

No change
---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index 8db660b..d285c8d 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -50,6 +50,9 @@
 		reg-offset = <0x1000>;
 
 		clocks	= <&ext>;
+
+		interrupt-parent = <&axi_intc>;
+		interrupts = <0>;
 	};
 };
 
-- 
1.9.1
