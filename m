Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <1329281884.20466.rusty@rustcorp.com.au>
Date: Wed, 15 Feb 2012 15:28:04 +1030
Subject: [PATCH 6/12] arch/powerpc: remove references to cpu_*_map.
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

This has been obsolescent for a while; time for the final push.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/wsp/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/wsp/smp.c b/arch/powerpc/platforms/wsp/smp.c
--- a/arch/powerpc/platforms/wsp/smp.c
+++ b/arch/powerpc/platforms/wsp/smp.c
@@ -71,7 +71,7 @@ int __devinit smp_a2_kick_cpu(int nr)
 
 static int __init smp_a2_probe(void)
 {
-	return cpus_weight(cpu_possible_map);
+	return num_possible_cpus();
 }
 
 static struct smp_ops_t a2_smp_ops = {
