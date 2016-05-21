Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x242.google.com (mail-lb0-x242.google.com
 [IPv6:2a00:1450:4010:c04::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk781jD5zDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:06:44 +1000 (AEST)
Received: by mail-lb0-x242.google.com with SMTP id r5so6880862lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:06:44 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 scottwood@freescale.com, mikey@neuling.org, cyrilbur@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0230/1529] Fix typo
Date: Sat, 21 May 2016 14:06:36 +0200
Message-Id: <20160521120636.11948-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/mm/hash_native_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index d873f65..0a4560d 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -55,7 +55,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 	 * We need 14 to 65 bits of va for a tlibe of 4K page
 	 * With vpn we ignore the lower VPN_SHIFT bits already.
 	 * And top two bits are already ignored because we can
-	 * only accomadate 76 bits in a 64 bit vpn with a VPN_SHIFT
+	 * only accomodate 76 bits in a 64 bit vpn with a VPN_SHIFT
 	 * of 12.
 	 */
 	va = vpn << VPN_SHIFT;
@@ -601,7 +601,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
  * crashdump and all bets are off anyway.
  *
  * TODO: add batching support when enabled.  remember, no dynamic memory here,
- * athough there is the control page available...
+ * although there is the control page available...
  */
 static void native_hpte_clear(void)
 {
-- 
2.8.2.534.g1f66975
