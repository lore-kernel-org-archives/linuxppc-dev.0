Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0 (Apple Message framework v613)
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <B755A2F6-8364-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-18--613454731
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Proposed Kconfig update patch for help text
Date: Wed, 31 Mar 2004 17:42:40 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-18--613454731
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

A couple of trivial changes for the processor choice help text to make
it a bit clearer.

John

--- Kconfig.orig    2004-03-31 17:25:53.000000000 -0500
+++ Kconfig 2004-03-31 17:38:57.000000000 -0500
@@ -44,13 +44,14 @@
     default 6xx

  config 6xx
-   bool "6xx/7xx/74xx/8260"
+   bool "6xx/7xx/74xx/82xx"
     help
-     There are four types of PowerPC chips supported.  The more common
+     There are four types of PowerPC chips supported: the more common
       types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-     versions (821, 823, 850, 855, 860, 8260), the IBM embedded
versions
+     versions (821, 823, 850, 855, 860, 82xx), the IBM embedded
versions
       (403 and 405) and the high end 64 bit Power processors (POWER 3,
-     POWER4, and IBM 970 also known as G5)
+     POWER4, and IBM 970 also known as G5).
+
       Unless you are building a kernel for one of the embedded processor
       systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
       Note that the kernel runs in 32-bit mode even on 64-bit chips.



--Apple-Mail-18--613454731
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0600;
	name="Kconfig.patch"
Content-Disposition: attachment;
	filename=Kconfig.patch

--- Kconfig.orig	2004-03-31 17:25:53.000000000 -0500
+++ Kconfig	2004-03-31 17:38:57.000000000 -0500
@@ -44,13 +44,14 @@
 	default 6xx

 config 6xx
-	bool "6xx/7xx/74xx/8260"
+	bool "6xx/7xx/74xx/82xx"
 	help
-	  There are four types of PowerPC chips supported.  The more common
+	  There are four types of PowerPC chips supported: the more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-	  versions (821, 823, 850, 855, 860, 8260), the IBM embedded versions
+	  versions (821, 823, 850, 855, 860, 82xx), the IBM embedded versions
 	  (403 and 405) and the high end 64 bit Power processors (POWER 3,
-	  POWER4, and IBM 970 also known as G5)
+	  POWER4, and IBM 970 also known as G5).
+
 	  Unless you are building a kernel for one of the embedded processor
 	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
 	  Note that the kernel runs in 32-bit mode even on 64-bit chips.

--Apple-Mail-18--613454731--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
