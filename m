Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id DE25EDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 19:10:55 +1000 (EST)
Date: Tue, 16 Sep 2008 11:10:54 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Kill outdated Documentation/powerpc/smp.txt
Message-ID: <Pine.LNX.4.64.0809161109100.1627@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-551635537-1221556254=:1627"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Cort Dougan <cort@fsmlabs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-551635537-1221556254=:1627
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Documentation/powerpc/smp.txt is so outdated that it makes sense to just
remove it.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 Documentation/powerpc/00-INDEX |    2 --
 Documentation/powerpc/smp.txt  |   34 ----------------------------------
 2 files changed, 36 deletions(-)

--- a/Documentation/powerpc/00-INDEX
+++ b/Documentation/powerpc/00-INDEX
@@ -18,8 +18,6 @@ mpc52xx.txt
 	- Linux 2.6.x on MPC52xx family
 mpc52xx-device-tree-bindings.txt
 	- MPC5200 Device Tree Bindings
-smp.txt
-	- use and state info about Linux/PPC on MP machines
 sound.txt
 	- info on sound support under Linux/PPC
 zImage_layout.txt
--- a/Documentation/powerpc/smp.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-                 Information about Linux/PPC SMP mode
-=====================================================================
-
-This document and the related code was written by me
-(Cort Dougan, cort@fsmlabs.com) please email me if you have questions,
-comments or corrections.
-
-Last Change: 3.31.99
-
-If you want to help by writing code or testing different hardware please
-email me!
-
-1. State of Supported Hardware
-
-  PowerSurge Architecture - tested on UMAX s900, Apple 9600
-    The second processor on this machine boots up just fine and
-    enters its idle loop.  Hopefully a completely working SMP kernel
-    on this machine will be done shortly.
-
-    The code makes the assumption of only two processors.  The changes
-    necessary to work with any number would not be overly difficult but
-    I don't have any machines with >2 processors so it's not high on my
-    list of priorities.  If anyone else would like do to the work email
-    me and I can point out the places that need changed.  If you have >2
-    processors and don't want to add support yourself let me know and I
-    can take a look into it.
-
-  BeBox
-    BeBox support hasn't been added to the 2.1.X kernels from 2.0.X
-    but work is being done and SMP support for BeBox is in the works.
-
-  CHRP
-    CHRP SMP works and is fairly solid.  It's been tested on the IBM F50
-    with 4 processors for quite some time now.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-551635537-1221556254=:1627--
