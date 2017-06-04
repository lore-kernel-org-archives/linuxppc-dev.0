Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wgtFy49d8zDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 08:40:54 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ingo Molnar <mingo@kernel.org>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: fix spelling mistake: "Attemping" ->
 "Attempting"
Date: Sun,  4 Jun 2017 23:40:42 +0100
Message-Id: <20170604224042.32165-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in pr_debug message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 7bc0e91f8715..6afd1efd3633 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -554,7 +554,7 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 {
 	int rc;
 
-	pr_debug("Attemping to remove CPU %s, drc index: %x\n",
+	pr_debug("Attempting to remove CPU %s, drc index: %x\n",
 		 dn->name, drc_index);
 
 	rc = dlpar_offline_cpu(dn);
-- 
2.11.0
