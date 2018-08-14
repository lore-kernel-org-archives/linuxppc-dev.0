Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qHNr47lyzF0WR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 12:58:52 +1000 (AEST)
From: zhong jiang <zhongjiang@huawei.com>
To: <tony.luck@intel.com>, <fenghua.yu@intel.com>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <oleg@redhat.com>,
 <rppt@linux.vnet.ibm.com>, <dhowells@redhat.com>,
 <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>
CC: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/2] Use ARRAY_SIZE to replace its implementation
Date: Tue, 14 Aug 2018 10:46:52 +0800
Message-ID: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The issue is detected with the help of Coccinelle.

zhong jiang (2):
  ia64: Use ARRAY_SIZE to replace its implementation
  powerpc: Use ARRAY_SIZE to replace its implementation

 arch/ia64/kernel/perfmon.c  |  2 +-
 arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

-- 
1.7.12.4
