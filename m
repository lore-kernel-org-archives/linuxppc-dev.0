Subject: [Fwd: PATCH: comment change against linuxppc-2.5 BK tree
	arch/ppc/platforms/4xx/ibm405lp.h (fwd)]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1069372559.703.38.camel@gaston>
Mime-Version: 1.0
Date: Fri, 21 Nov 2003 10:55:59 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----Forwarded Message-----
From: "Verberk, Bep" <verberk@nortelnetworks.com>
Subject: PATCH: comment change against linuxppc-2.5 BK tree arch/ppc/platforms/4xx/ibm405lp.h (fwd)
Date: Tue, 18 Nov 2003 16:39:20 -0500

Gents,
this is a trivial change.
I wouldn't have bothered but its my first ever kernel change and
I wanted to pipe-clean my understanding of the process.

Not sure if diff-ing it
against the latest BK snapshot is OK.  Let me know I can re-do it.
I've just started going through the 405 code so I may have
more input later and I'd like to make sure I'm submitting it properly.

Now I'll go try to find a real bug :)

Cheers,
Bep

diff -urN linuxppc-2.5/arch/ppc/platforms/4xx/ibm405lp.h
linux/arch/ppc/platforms/4xx/ibm405lp.h
--- linuxppc-2.5/arch/ppc/platforms/4xx/ibm405lp.h      2003-11-18
16:08:11.000000000 -0500
+++ linux/arch/ppc/platforms/4xx/ibm405lp.h     2003-11-18
16:19:10.000000000 -0500
@@ -199,7 +199,7 @@
 #define DCRN_EBC0_B7AP  0x17   /* Peripheral Bank 7 Access Parameters */
 #define DCRN_EBC0_BEAR  0x20   /* Periperal Bus Error Address Register */
 #define DCRN_EBC0_BESR0 0x21   /* Peripheral Bus Error Status Register 0 */
-#define DCRN_EBC0_BESR1 0x22   /* Peripheral Bus Error Status Register 0 */
+#define DCRN_EBC0_BESR1 0x22   /* Peripheral Bus Error Status Register 1 */
 #define DCRN_EBC0_CFG   0x23   /* External Peripheral Control Register */

 #define EBC0_BANKS           8

--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
