Date: Sun, 7 Sep 2003 18:39:34 +0200
From: Matthias Grimm <matthias.grimm@htp-tel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] 2.4.21-benh2 - new values in pmu.h
Message-Id: <20030907183934.7e8c93c5.matthias.grimm@htp-tel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Here is a patch that adds some values in pmu.h and corrects another one.
This values were discovered during work on my project pbbuttonsd.

Kernel:	          2.4.21-benh
Dir to change to: include/linux
Patch param:      -p0

  Best Regards
    Matthias

--- pmu.h.old	Sat Aug 23 19:44:30 2003
+++ pmu.h	Sun Sep  7 18:08:51 2003
@@ -24,6 +24,7 @@
 #define PMU_SET_VOLBUTTON	0x40	/* set volume up/down position */
 #define PMU_BACKLIGHT_BRIGHT	0x41	/* set backlight brightness */
 #define PMU_GET_VOLBUTTON	0x48	/* get volume up/down position */
+#define PMU_GET_BRIGHTBUTTON	0x49	/* get brightness up/down on OHARE */
 #define PMU_PCEJECT		0x4c	/* eject PC-card from slot */
 #define PMU_BATTERY_STATE	0x6b	/* report battery state etc. */
 #define PMU_SMART_BATTERY_STATE	0x6f	/* report battery state (new way) */
@@ -35,7 +36,7 @@
 #define PMU_POWER_EVENTS	0x8f	/* Send power-event commands to PMU */
 #define PMU_I2C_CMD		0x9a	/* I2C operations */
 #define PMU_RESET		0xd0	/* reset CPU */
-#define PMU_GET_BRIGHTBUTTON	0xd9	/* report brightness up/down pos */
+/* #define PMU_GET_BRIGHTBUTTON	0xd9	 report brightness up/down pos */
 #define PMU_GET_COVER		0xdc	/* report cover open/closed */
 #define PMU_SYSTEM_READY	0xdf	/* tell PMU we are awake */
 #define PMU_GET_VERSION		0xea	/* read the PMU version */
@@ -69,6 +70,8 @@
 /* Bits in the environement message (either obtained via PMU_GET_COVER,
  * or via PMU_INT_ENVIRONMENT on core99 */
 #define PMU_ENV_LID_CLOSED	0x01	/* The lid is closed */
+#define PMU_ENV_AC_POWER	0x04	/* AC power connected */
+#define PMU_ENV_BATTERY_PRESENT	0x10	/* right or left battery is present */

 /* I2C related definitions */
 #define PMU_I2C_MODE_SIMPLE	0

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
