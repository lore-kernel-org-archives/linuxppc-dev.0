Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 21 Jun 2012 12:04:37 +1000
Subject: [PATCH 10/18] powerpc: change LOAD_REG_ADDR to use real register names
In-Reply-To: <1340244266.960241.475925824909.qpush@ale>
Message-Id: <20120621020437.4C9DAD431D9@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LOAD_REG_ADDR define is just a wrapper around real instructions so we
can just use real register names here (ie. lower case).

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: powerpc-test/arch/powerpc/platforms/powernv/opal-wrappers.S
===================================================================
--- powerpc-test.orig/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ powerpc-test/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -32,7 +32,7 @@
 	std	r12,PACASAVEDMSR(r13);	\
 	andc	r12,r12,r0;		\
 	mtmsrd	r12,1;			\
-	LOAD_REG_ADDR(R0,.opal_return);	\
+	LOAD_REG_ADDR(r0,.opal_return);	\
 	mtlr	r0;			\
 	li	r0,MSR_DR|MSR_IR;	\
 	andc	r12,r12,r0;		\
