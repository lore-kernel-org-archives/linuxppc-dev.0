Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9666FDDF41
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:01:28 +1100 (EST)
Date: Fri, 14 Dec 2007 02:06:55 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [POWERPC] pasemi: export pasemi_dma_init()
Message-ID: <20071214080655.GA27284@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Forgot to export this one. Needed when pasemi_mac is compiled as a module.

Signed-off-by: Olof Johansson <olof@lixom.net>

---

Jeff, since the dma_lib stuff went up through netdev-2.6, please apply and
feed this one up with the rest.


Thanks,

Olof

Index: 2.6.24/arch/powerpc/platforms/pasemi/dma_lib.c
===================================================================
--- 2.6.24.orig/arch/powerpc/platforms/pasemi/dma_lib.c
+++ 2.6.24/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -485,3 +485,4 @@ out:
 	spin_unlock(&init_lock);
 	return err;
 }
+EXPORT_SYMBOL(pasemi_dma_init);
