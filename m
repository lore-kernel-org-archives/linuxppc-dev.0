Date: Mon, 27 Nov 2000 21:50:46 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Hadess <hadess@writeme.com>, Avery Pennarun <apenwarr@worldvisions.ca>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <Pine.LNX.4.10.10011271404350.16628-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10011272149080.3774-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> My contribution to kernel bloat ... untested except on Lombard, the 3400

Followup: I forgot the following little patch to pmu.h. Paul, BenH, can we
please get this into the kernel source?

	Michael

--- include/asm/pmu.h.org	Fri Nov 24 14:25:38 2000
+++ include/asm/pmu.h	Fri Nov 24 14:25:21 2000
@@ -23,6 +23,7 @@
 #define PMU_GET_VOLBUTTON	0x48	/* get volume up/down position */
 #define PMU_PCEJECT		0x4c	/* eject PC-card from slot */
 #define PMU_BATTERY_STATE	0x6b	/* report battery state etc. */
+#define PMU_SMART_BATT		0x6f	/* report smart battery state */
 #define PMU_SET_INTR_MASK	0x70	/* set PMU interrupt mask */
 #define PMU_INT_ACK		0x78	/* read interrupt bits */
 #define PMU_SHUTDOWN		0x7e	/* turn power off */
@@ -32,6 +33,7 @@
 #define PMU_GET_BRIGHTBUTTON	0xd9	/* report brightness up/down pos */
 #define PMU_GET_COVER		0xdc	/* report cover open/closed */
 #define PMU_SYSTEM_READY	0xdf	/* tell PMU we are awake */
+#define PMU_GET_VERSION		0xea	/* get pmu firmware version # */

 /* Bits to use with the PMU_POWER_CTRL0 command */
 #define PMU_POW0_ON		0x80	/* OR this to power ON the device */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
