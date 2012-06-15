Return-Path: <liwp.linux@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62D42B70C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 23:18:04 +1000 (EST)
Received: by dajt11 with SMTP id t11so4422607daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 06:18:02 -0700 (PDT)
From: Wanpeng Li <liwp.linux@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 4/7][TRIVIAL][resend] mm: cleanup on the comments of
 zone_reclaim_stat
Date: Fri, 15 Jun 2012 21:17:16 +0800
Message-Id: <1339766240-7622-1-git-send-email-liwp.linux@gmail.com>
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

Signed-off-by: Wanpeng Li <liwp.linux@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>

---
 include/linux/mmzone.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 2427706..d6a5f83 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -188,7 +188,7 @@ static inline int is_unevictable_lru(enum lru_list lru)
 struct zone_reclaim_stat {
 	/*
 	 * The pageout code in vmscan.c keeps track of how many of the
-	 * mem/swap backed and file backed pages are refeferenced.
+	 * mem/swap backed and file backed pages are referenced.
 	 * The higher the rotated/scanned ratio, the more valuable
 	 * that cache is.
 	 *
-- 
1.7.9.5
