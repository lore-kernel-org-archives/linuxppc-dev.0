Date: Fri, 12 Dec 2003 22:56:01 +0100
From: Wouter Cloetens <wouter@mind.be>
To: linuxppc-embedded@lists.linuxppc.org
Cc: v2p@mind.be
Subject: [PATCH] Insight Memec Virtex-II Pro Development Board support
Message-ID: <20031212215601.GH3935@roadkill.intern.mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mind is making available a set of Linux kernel patches adding support for the Insight
Memec Virtex-II Pro Development Board using Memec's reference design for Linux on
ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/.

This version of the patches is against kernel version 2.4.23 in the
linuxppc_2_4_devel tree, BitKeeper tag v2.4.23_linuxppc_2_4_devel.

If needed, we can also submit the diff against the linuxppc_2_4 tree.

We commit to maintaining this port on an ongoing basis against the
linuxppc_2_4 tree.

The patches should be applied in the following order:
 ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/patch-platform-insightv2pro
   board-specific platform support
   patch for the 405D5X[12] CPU_212 bug (see http://support.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&iCountryID=1&getPagePath=14052)
 ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/patch-uartlite
   Xilinx UART Lite support (not board-specific)
 ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/patch-memec-emac
   MemecCore Ethernet MAC support (not board-specific)
 ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/patch-mtd
   MTD support for the NOR flash on the P160 comm module
 ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4_devel/patch-defconfig
   board default configuration

--
There are 10 types of people in the world: Those who understand binary, and those who don't.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
