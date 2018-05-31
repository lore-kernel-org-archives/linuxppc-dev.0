Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF3W17WfzDrcW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:14 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 02/11] powerpc/prom_init: Make "fake_elf" const
Date: Thu, 31 May 2018 14:33:40 +1000
Message-Id: <20180531043349.24783-3-benh@kernel.crashing.org>
In-Reply-To: <20180531043349.24783-1-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is never modified

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d6f52cc141c3..158f9ece064e 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -897,7 +897,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 
 /* Old method - ELF header with PT_NOTE sections only works on BE */
 #ifdef __BIG_ENDIAN__
-static struct fake_elf {
+static const struct fake_elf {
 	Elf32_Ehdr	elfhdr;
 	Elf32_Phdr	phdr[2];
 	struct chrpnote {
-- 
2.17.0
