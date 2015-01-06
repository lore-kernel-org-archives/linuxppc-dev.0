Return-Path: <esben.haabendal@gmail.com>
Received: from mail-la0-x22b.google.com (mail-la0-x22b.google.com
 [IPv6:2a00:1450:4010:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25CE01A078E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 22:27:14 +1100 (AEDT)
Received: by mail-la0-f43.google.com with SMTP id s18so19983675lam.16
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jan 2015 03:27:10 -0800 (PST)
Sender: Esben Haabendal <esbenhaabendal@gmail.com>
From: esben.haabendal@gmail.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/3] powerpc: Add machine_check cpu function for e300c3 cpus
Date: Tue,  6 Jan 2015 12:26:59 +0100
Message-Id: <1420543620-20658-2-git-send-email-esben.haabendal@gmail.com>
In-Reply-To: <1420543620-20658-1-git-send-email-esben.haabendal@gmail.com>
References: <1420543620-20658-1-git-send-email-esben.haabendal@gmail.com>
Cc: Esben Haabendal <eha@deif.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Esben Haabendal <eha@deif.com>

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/powerpc/kernel/cputable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 8084059..f337666 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1133,6 +1133,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e300",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
-- 
2.1.4
