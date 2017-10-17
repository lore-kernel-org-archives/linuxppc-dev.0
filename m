Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGYw32s4DzDrFy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:12:02 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bhumika Goyal <bhumirks@gmail.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] PowerPC-OPAL: Adjustments for some function
 implementations
Message-ID: <5fb4f314-cd23-c439-ab13-96b8188070e0@users.sourceforge.net>
Date: Tue, 17 Oct 2017 14:10:19 +0200
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
Date: Tue, 17 Oct 2017 13:45:54 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete ten error messages for a failed memory allocation
  Improve 12 size determinations
  Fix a typo in a comment line of two file headers

 arch/powerpc/platforms/powernv/opal-async.c        |  2 --
 arch/powerpc/platforms/powernv/opal-dump.c         |  1 -
 arch/powerpc/platforms/powernv/opal-flash.c        |  8 +++----
 arch/powerpc/platforms/powernv/opal-hmi.c          |  9 ++++----
 arch/powerpc/platforms/powernv/opal-imc.c          | 10 ++++-----
 .../powerpc/platforms/powernv/opal-memory-errors.c | 10 ++++-----
 arch/powerpc/platforms/powernv/opal-psr.c          |  2 +-
 .../powerpc/platforms/powernv/opal-sensor-groups.c |  4 ++--
 arch/powerpc/platforms/powernv/opal-sysparam.c     | 25 +++++-----------------
 arch/powerpc/platforms/powernv/opal-xscom.c        |  2 +-
 10 files changed, 25 insertions(+), 48 deletions(-)

-- 
2.14.2
