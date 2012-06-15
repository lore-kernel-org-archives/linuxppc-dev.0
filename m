Return-Path: <liwp.linux@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8E08B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 23:16:25 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so5978700pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 06:16:24 -0700 (PDT)
From: Wanpeng Li <liwp.linux@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 3/7][TRIVIAL][resend] drivers/pci: cleanup kernel-doc warning
Date: Fri, 15 Jun 2012 21:15:49 +0800
Message-Id: <1339766154-7470-1-git-send-email-liwp.linux@gmail.com>
Cc: Christoph Lameter <cl@linux-foundation.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, David Howells <dhowells@redhat.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
 Wanpeng Li <liwp.linux@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Mel Gorman <mel@csn.ul.ie>, Jason Wessel <jason.wessel@windriver.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>,
 cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Minchan Kim <minchan@kernel.org>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wanpeng Li <liwp@linux.vnet.ibm.com>

Warning(drivers/pci/setup-bus.c:277): No description found for parameter 'fail_head'
Warning(drivers/pci/setup-bus.c:277): Excess function parameter 'failed_list' description in 'assign_requested_resources_sorted'

Signed-off-by: Wanpeng Li <liwp.linux@gmail.com>
---
 drivers/pci/setup-bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8fa2d4b..9165d25 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -265,7 +265,7 @@ out:
  * assign_requested_resources_sorted() - satisfy resource requests
  *
  * @head : head of the list tracking requests for resources
- * @failed_list : head of the list tracking requests that could
+ * @fail_head : head of the list tracking requests that could
  *		not be allocated
  *
  * Satisfy resource requests of each element in the list. Add
-- 
1.7.9.5
