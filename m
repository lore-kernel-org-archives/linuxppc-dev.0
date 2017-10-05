Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7H6D0xM8zDr8K
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 02:40:35 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net,
 Al Viro <viro@zeniv.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Robert Richter <rric@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] PowerPC-Cell OProfile: Adjustments for three function
 implementations
Message-ID: <596db1f4-5965-d6f8-af02-38b570b10d8a@users.sourceforge.net>
Date: Thu, 5 Oct 2017 17:40:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Oct 2017 17:32:10 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in three functions
  Improve a size determination in two functions

 arch/powerpc/oprofile/cell/spu_task_sync.c | 10 +---------
 arch/powerpc/oprofile/cell/vma_map.c       |  6 ++----
 2 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.14.2
