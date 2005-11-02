Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 0F3F968678
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 06:55:16 +1100 (EST)
Message-ID: <436919A2.7050108@ru.mvista.com>
Date: Wed, 02 Nov 2005 22:55:14 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Content-Type: multipart/mixed; boundary="------------050905040700040209080701"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fixed warning
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050905040700040209080701
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This adds missing header and thus fix the warning issued by ming prototype.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely,
Vitaly

--------------050905040700040209080701
Content-Type: text/x-patch;
 name="8xx_setup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8xx_setup.patch"

diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -45,6 +45,7 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/xmon.h>
+#include <asm/ppc_sys.h>
 
 #include "ppc8xx_pic.h"
 

--------------050905040700040209080701--
