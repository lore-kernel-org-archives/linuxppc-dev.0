Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7NJg2hkfzDrN5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 06:34:58 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] PowerPC-Cell platform: Adjustments for four function
 implementations
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <db9efaf4-f3d7-d5dc-b0b2-f20e418fa3c8@users.sourceforge.net>
Date: Thu, 5 Oct 2017 21:34:32 +0200
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
Date: Thu, 5 Oct 2017 21:25:43 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in three functions
  Improve a size determination in three functions

 arch/powerpc/platforms/cell/axon_msi.c          |  7 ++-----
 arch/powerpc/platforms/cell/spider-pci.c        | 11 +++--------
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c |  2 +-
 3 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.14.2
