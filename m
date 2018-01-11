Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHYXT1KmMzF0dH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 04:58:48 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] powerpc/platforms/4xx: Adjustments for six function
 implementations
Message-ID: <2b9b4285-f1c0-5dc7-35c6-df901c9ca0eb@users.sourceforge.net>
Date: Thu, 11 Jan 2018 18:58:21 +0100
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
Date: Thu, 11 Jan 2018 18:48:28 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Combine four seq_printf() calls into two in ocm_debugfs_show()
  Use seq_putc() in ocm_debugfs_show()
  Delete an error message for a failed memory allocation in three functions
  Improve a size determination in two functions
  Delete an unnecessary return statement in two functions

 arch/powerpc/platforms/4xx/msi.c |  7 +++----
 arch/powerpc/platforms/4xx/ocm.c | 19 +++++--------------
 arch/powerpc/platforms/4xx/pci.c |  1 -
 3 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.15.1
