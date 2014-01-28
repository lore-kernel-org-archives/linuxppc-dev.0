Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0022.hostedemail.com
 [216.40.44.22]) by ozlabs.org (Postfix) with ESMTP id 5D5742C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 05:22:26 +1100 (EST)
Message-ID: <1390933342.11756.12.camel@joe-AO722>
Subject: [PATCH] powerpc: numa: Fix decimal permissions
From: Joe Perches <joe@perches.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>
Date: Tue, 28 Jan 2014 10:22:22 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should have been octal.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 86a63de..30a42e2 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1785,7 +1785,7 @@ static const struct file_operations topology_ops = {
 static int topology_update_init(void)
 {
 	start_topology_update();
-	proc_create("powerpc/topology_updates", 644, NULL, &topology_ops);
+	proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops);
 
 	return 0;
 }
