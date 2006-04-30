Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D99BA67A6B
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 14:54:05 +1000 (EST)
Date: Sat, 29 Apr 2006 23:53:46 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Fix comment in ibm_architecture_vec
Message-ID: <20060430045346.GQ5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 29, 2006 at 04:15:10PM +1000, Paul Mackerras wrote:

> Paul Mackerras:
>       powerpc/pseries: Tell firmware our capabilities on new machines

Below is definitely not 2.6.17 material, so for the 2.6.18 queue:

---

Either constant or comment is wrong, I'm guessing it's comment since the
ELF header version uses 64MB.

Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 078fb55..ef99f26 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -705,7 +705,7 @@ static unsigned char ibm_architecture_ve
 	W(0xffffffff),			/* virt_base */
 	W(0xffffffff),			/* virt_size */
 	W(0xffffffff),			/* load_base */
-	W(64),				/* 128MB min RMA */
+	W(64),				/* 64MB min RMA */
 	W(0xffffffff),			/* full client load */
 	0,				/* min RMA percentage of total RAM */
 	48,				/* max log_2(hash table size) */
