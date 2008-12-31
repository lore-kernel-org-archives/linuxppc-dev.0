Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EFEACDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 14:09:15 +1100 (EST)
Date: Wed, 31 Dec 2008 14:09:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/cell: local_irq_save takes an unsigned long
Message-Id: <20081231140915.75067edd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../powerpc/platforms/cell/cbe_cpufreq_pervasive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c b/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c
index 70fa7ae..20472e4 100644
--- a/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c
+++ b/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c
@@ -54,7 +54,7 @@ int cbe_cpufreq_set_pmode(int cpu, unsigned int pmode)
 {
 	struct cbe_pmd_regs __iomem *pmd_regs;
 	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
-	u64 flags;
+	unsigned long flags;
 	u64 value;
 #ifdef DEBUG
 	long time;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
