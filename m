Return-Path: <fabf@skynet.be>
Received: from mailrelay110.isp.belgacom.be (mailrelay110.isp.belgacom.be
 [195.238.20.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tWnfc0vx1zDvnv
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2016 23:45:10 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, fabf@skynet.be
Subject: [PATCH 1/1 linux-next] soc/qman: test: use DEFINE_SPINLOCK()
Date: Sun,  4 Dec 2016 13:44:59 +0100
Message-Id: <1480855499-19565-1-git-send-email-fabf@skynet.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/soc/fsl/qbman/qman_test_stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index b9795f3..e87b654 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -175,7 +175,7 @@ static DEFINE_PER_CPU(struct hp_cpu, hp_cpus);
 
 /* links together the hp_cpu structs, in first-come first-serve order. */
 static LIST_HEAD(hp_cpu_list);
-static spinlock_t hp_lock = __SPIN_LOCK_UNLOCKED(hp_lock);
+static DEFINE_SPINLOCK(hp_lock);
 
 static unsigned int hp_cpu_list_length;
 
-- 
2.7.4
