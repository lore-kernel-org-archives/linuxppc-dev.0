Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 08 Jun 2012 21:36:05 +1000
Subject: [PATCH 9/15] powerpc: change LOAD_REG_ADDR to use real register names
In-Reply-To: <1339155365.316308.981577666228.qpush@ale>
Message-Id: <20120608113605.8B709D43B2E@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org,
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

Index: clone3/arch/powerpc/platforms/powernv/opal-wrappers.S
===================================================================
--- clone3.orig/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ clone3/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -32,7 +32,7 @@
 	std	r12,PACASAVEDMSR(r13);	\
 	andc	r12,r12,r0;		\
 	mtmsrd	r12,1;			\
-	LOAD_REG_ADDR(R0,.opal_return);	\
+	LOAD_REG_ADDR(r0,.opal_return);	\
 	mtlr	r0;			\
 	li	r0,MSR_DR|MSR_IR;	\
 	andc	r12,r12,r0;		\
