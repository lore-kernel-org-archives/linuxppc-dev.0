Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 3E7B7DDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 06:55:53 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/usb/: Spelling fixes
Date: Mon, 17 Dec 2007 11:40:18 -0800
Message-Id: <1197920439-5455-12-git-send-email-joe@perches.com>
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918893.git.joe@perches.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	Oliver Neukum <oliver@neukum.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, linux-usb@vger.kernel.org,
	Thomas Winischhofer <thomas@winischhofer.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/usb/atm/ueagle-atm.c        |    2 +-
 drivers/usb/class/cdc-acm.c         |    2 +-
 drivers/usb/gadget/at91_udc.h       |    2 +-
 drivers/usb/gadget/fsl_usb2_udc.c   |    2 +-
 drivers/usb/gadget/omap_udc.c       |    2 +-
 drivers/usb/host/ehci-fsl.c         |    2 +-
 drivers/usb/host/ehci-sched.c       |    2 +-
 drivers/usb/host/r8a66597.h         |    2 +-
 drivers/usb/misc/sisusbvga/sisusb.c |    2 +-
 drivers/usb/misc/usbtest.c          |    2 +-
 drivers/usb/serial/io_edgeport.c    |    8 ++++----
 drivers/usb/serial/mos7840.c        |    8 ++++----
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 389c5b1..e087dc6 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -999,7 +999,7 @@ static void __uea_load_page_e4(struct uea_softc *sc, u8 pageno, int boot)
 		bi.dwAddress = swab32(blockidx->PageAddress);
 
 		uea_dbg(INS_TO_USBDEV(sc),
-		       "sending block %u for DSP page %u size %u adress %x\n",
+		       "sending block %u for DSP page %u size %u address %x\n",
 		       blockno, pageno, blocksize, le32_to_cpu(blockidx->PageAddress));
 
 		/* send block info through the IDMA pipe */
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 912d97a..bac0a11 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -904,7 +904,7 @@ next_desc:
 	}
 	
 	if (data_interface_num != call_interface_num)
-		dev_dbg(&intf->dev,"Seperate call control interface. That is not fully supported.\n");
+		dev_dbg(&intf->dev,"Separate call control interface. That is not fully supported.\n");
 
 skip_normal_probe:
 
diff --git a/drivers/usb/gadget/at91_udc.h b/drivers/usb/gadget/at91_udc.h
index 7e34e2f..ede7ab0 100644
--- a/drivers/usb/gadget/at91_udc.h
+++ b/drivers/usb/gadget/at91_udc.h
@@ -53,7 +53,7 @@
 #define     AT91_UDP_RXRSM	(1 <<  9)	/* USB Resume Interrupt Status */
 #define     AT91_UDP_EXTRSM	(1 << 10)	/* External Resume Interrupt Status [AT91RM9200 only] */
 #define     AT91_UDP_SOFINT	(1 << 11)	/* Start of Frame Interrupt Status */
-#define     AT91_UDP_ENDBUSRES	(1 << 12)	/* End of Bus Reset Interrpt Status */
+#define     AT91_UDP_ENDBUSRES	(1 << 12)	/* End of Bus Reset Interrupt Status */
 #define     AT91_UDP_WAKEUP	(1 << 13)	/* USB Wakeup Interrupt Status [AT91RM9200 only] */
 
 #define AT91_UDP_ICR		0x20		/* Interrupt Clear Register */
diff --git a/drivers/usb/gadget/fsl_usb2_udc.c b/drivers/usb/gadget/fsl_usb2_udc.c
index 9bb7f64..0ac5567 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.c
+++ b/drivers/usb/gadget/fsl_usb2_udc.c
@@ -1896,7 +1896,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 
 	spin_lock_irqsave(&udc->lock, flags);
 
-	/* ------basic driver infomation ---- */
+	/* ------basic driver information ---- */
 	t = scnprintf(next, size,
 			DRIVER_DESC "\n"
 			"%s version: %s\n"
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index d377154..907b92e 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -1001,7 +1001,7 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 
 				/* STATUS for zero length DATA stages is
 				 * always an IN ... even for IN transfers,
-				 * a wierd case which seem to stall OMAP.
+				 * a weird case which seem to stall OMAP.
 				 */
 				UDC_EP_NUM_REG = (UDC_EP_SEL|UDC_EP_DIR);
 				UDC_CTRL_REG = UDC_CLR_EP;
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index b7b7bfb..271d4c9 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -25,7 +25,7 @@
 
 #include "ehci-fsl.h"
 
-/* FIXME: Power Managment is un-ported so temporarily disable it */
+/* FIXME: Power Management is un-ported so temporarily disable it */
 #undef CONFIG_PM
 
 /* PCI-based HCs are common, but plenty of non-PCI HCs are used too */
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 80d99bc..dce305b 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -211,7 +211,7 @@ static inline void carryover_tt_bandwidth(unsigned short tt_usecs[8])
  * low/fullspeed transfer can "carry over" from one uframe to the next,
  * since the TT just performs downstream transfers in sequence.
  *
- * For example two seperate 100 usec transfers can start in the same uframe,
+ * For example two separate 100 usec transfers can start in the same uframe,
  * and the second one would "carry over" 75 usecs into the next uframe.
  */
 static void
diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
index fe9ceb0..5738825 100644
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -405,7 +405,7 @@
 
 struct r8a66597_pipe_info {
 	u16 pipenum;
-	u16 address;	/* R8A66597 HCD usb addres */
+	u16 address;	/* R8A66597 HCD usb address */
 	u16 epnum;
 	u16 maxpacket;
 	u16 type;
diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index 9244d06..e68ae84 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -323,7 +323,7 @@ sisusb_bulkin_msg(struct sisusb_usb_data *sisusb, unsigned int pipe, void *data,
 			usb_kill_urb(urb);
 			retval = -ETIMEDOUT;
 		} else {
-			/* URB completed within timout */
+			/* URB completed within timeout */
 			retval = urb->status;
 			readbytes = urb->actual_length;
 		}
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index ea31621..2083a75 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -1310,7 +1310,7 @@ static int ctrl_out (struct usbtest_dev *dev,
 		len += vary;
 
 		/* [real world] the "zero bytes IN" case isn't really used.
-		 * hardware can easily trip up in this wierd case, since its
+		 * hardware can easily trip up in this weird case, since its
 		 * status stage is IN, not OUT like other ep0in transfers.
 		 */
 		if (len > length)
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index a5d2e11..3428ccc 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -959,7 +959,7 @@ static int edge_open (struct usb_serial_port *port, struct file * filp)
  *
  *	This function will block the close until one of the following:
  *		1. Response to our Chase comes from Edgeport
- *		2. A timout of 10 seconds without activity has expired
+ *		2. A timeout of 10 seconds without activity has expired
  *		   (1K of Edgeport data @ 2400 baud ==> 4 sec to empty)
  *
  ************************************************************************/
@@ -999,7 +999,7 @@ static void block_until_chase_response(struct edgeport_port *edge_port)
 				return;
 			}
 		} else {
-			// Reset timout value back to 10 seconds
+			// Reset timeout value back to 10 seconds
 			dbg("%s - Last %d, Current %d", __FUNCTION__, lastCredits, edge_port->txCredits);
 			loop = 10;
 		}
@@ -1014,7 +1014,7 @@ static void block_until_chase_response(struct edgeport_port *edge_port)
  *	This function will block the close until one of the following:
  *		1. TX count are 0
  *		2. The edgeport has stopped
- *		3. A timout of 3 seconds without activity has expired
+ *		3. A timeout of 3 seconds without activity has expired
  *
  ************************************************************************/
 static void block_until_tx_empty (struct edgeport_port *edge_port)
@@ -1050,7 +1050,7 @@ static void block_until_tx_empty (struct edgeport_port *edge_port)
 				return;
 			}
 		} else {
-			// Reset timout value back to seconds
+			// Reset timeout value back to seconds
 			loop = 30;
 		}
 	}
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index c29c912..869ecd3 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1133,7 +1133,7 @@ static int mos7840_chars_in_buffer(struct usb_serial_port *port)
  *	This function will block the close until one of the following:
  *		1. TX count are 0
  *		2. The mos7840 has stopped
- *		3. A timout of 3 seconds without activity has expired
+ *		3. A timeout of 3 seconds without activity has expired
  *
  ************************************************************************/
 static void mos7840_block_until_tx_empty(struct moschip_port *mos7840_port)
@@ -1161,7 +1161,7 @@ static void mos7840_block_until_tx_empty(struct moschip_port *mos7840_port)
 			dbg("%s - TIMEOUT", __FUNCTION__);
 			return;
 		} else {
-			/* Reset timout value back to seconds */
+			/* Reset timeout value back to seconds */
 			wait = 30;
 		}
 	}
@@ -1275,7 +1275,7 @@ static void mos7840_close(struct usb_serial_port *port, struct file *filp)
  *
  *	This function will block the close until one of the following:
  *		1. Response to our Chase comes from mos7840
- *		2. A timout of 10 seconds without activity has expired
+ *		2. A timeout of 10 seconds without activity has expired
  *		   (1K of mos7840 data @ 2400 baud ==> 4 sec to empty)
  *
  ************************************************************************/
@@ -1304,7 +1304,7 @@ static void mos7840_block_until_chase_response(struct moschip_port
 			dbg("%s - TIMEOUT", __FUNCTION__);
 			return;
 		} else {
-			/* Reset timout value back to seconds */
+			/* Reset timeout value back to seconds */
 			wait = 10;
 		}
 	}
-- 
1.5.3.7.949.g2221a6
