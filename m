Date: Sun, 25 Jan 2004 17:05:09 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] Hydra Mac I/O
Message-ID: <Pine.GSO.4.58.0401251704150.20527@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Woops, forgot the subject. Repost...

---------- Forwarded message ----------
Date: Sun, 25 Jan 2004 12:31:02 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>,
     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
     Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>

	Hi,

This patch converts <asm/hydra.h> to use explicit-sized types.
It also applies to 2.4.

--- linux-ppc-2.6.0/include/asm-ppc/hydra.h.orig	2003-12-18 10:19:34.000000000 +0100
+++ linux-ppc-2.6.0/include/asm-ppc/hydra.h	2004-01-21 22:30:39.000000000 +0100
@@ -27,28 +27,28 @@

 struct Hydra {
     /* DBDMA Controller Register Space */
-    char Pad1[0x30];
-    u_int CachePD;
-    u_int IDs;
-    u_int Feature_Control;
-    char Pad2[0x7fc4];
+    u8 Pad1[0x30];
+    u32 CachePD;
+    u32 IDs;
+    u32 Feature_Control;
+    u8 Pad2[0x7fc4];
     /* DBDMA Channel Register Space */
-    char SCSI_DMA[0x100];
-    char Pad3[0x300];
-    char SCCA_Tx_DMA[0x100];
-    char SCCA_Rx_DMA[0x100];
-    char SCCB_Tx_DMA[0x100];
-    char SCCB_Rx_DMA[0x100];
-    char Pad4[0x7800];
+    u8 SCSI_DMA[0x100];
+    u8 Pad3[0x300];
+    u8 SCCA_Tx_DMA[0x100];
+    u8 SCCA_Rx_DMA[0x100];
+    u8 SCCB_Tx_DMA[0x100];
+    u8 SCCB_Rx_DMA[0x100];
+    u8 Pad4[0x7800];
     /* Device Register Space */
-    char SCSI[0x1000];
-    char ADB[0x1000];
-    char SCC_Legacy[0x1000];
-    char SCC[0x1000];
-    char Pad9[0x2000];
-    char VIA[0x2000];
-    char Pad10[0x28000];
-    char OpenPIC[0x40000];
+    u8 SCSI[0x1000];
+    u8 ADB[0x1000];
+    u8 SCC_Legacy[0x1000];
+    u8 SCC[0x1000];
+    u8 Pad9[0x2000];
+    u8 VIA[0x2000];
+    u8 Pad10[0x28000];
+    u8 OpenPIC[0x40000];
 };

 extern volatile struct Hydra *Hydra;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
