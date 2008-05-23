Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8FC8ADE181
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 22:14:19 +1000 (EST)
Date: Fri, 23 May 2008 16:14:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] booting-without-of: fix GPIO section mis-numbering
Message-ID: <20080523121417.GA8300@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Specifying GPIO information for devices" should be IX-th section,
not VIII-th.

Thanks to David Brownell for noticing.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1d2a772..0f83d43 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -88,7 +88,7 @@ Table of Contents
     3) OpenPIC Interrupt Controllers
     4) ISA Interrupt Controllers
 
-  VIII - Specifying GPIO information for devices
+  IX - Specifying GPIO information for devices
     1) gpios property
     2) gpio-controller nodes
 
@@ -3477,8 +3477,8 @@ encodings listed below:
 	2 =  high to low edge sensitive type enabled
 	3 =  low to high edge sensitive type enabled
 
-VIII - Specifying GPIO information for devices
-==============================================
+IX - Specifying GPIO information for devices
+============================================
 
 1) gpios property
 -----------------
-- 
1.5.5.1
