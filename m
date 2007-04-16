Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CB4DDDDF33
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:09:43 +1000 (EST)
Date: Mon, 16 Apr 2007 01:27:45 -0500
To: paulus@samba.org
Subject: [PATCH] [2/5] pasemi: enable one more hid bit
Message-ID: <20070416062745.GD20196@lixom.net>
References: <20070416062634.GB20196@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416062634.GB20196@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Minor HID change. Firmware can't know that we want this set so we have
to set it in the kernel.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/arch/powerpc/kernel/cpu_setup_pa6t.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_pa6t.S
+++ linux-2.6/arch/powerpc/kernel/cpu_setup_pa6t.S
@@ -34,7 +34,7 @@ _GLOBAL(__setup_cpu_pa6t)
 	beqlr
 
 	mfspr	r0,SPRN_HID5
-	ori	r0,r0,0x30
+	ori	r0,r0,0x38
 	mtspr	SPRN_HID5,r0
 
 	mfspr	r0,SPRN_LPCR
