Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNfvZ413NzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 05:17:30 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] axonram: Adjustments for axon_ram_probe()
Message-ID: <009fdef0-b2c9-5e98-d32d-14149aec92c5@users.sourceforge.net>
Date: Thu, 3 Aug 2017 21:11:15 +0200
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
Date: Thu, 3 Aug 2017 21:02:02 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation
  Improve a size determination in axon_ram_probe()
  Return directly after a failed kzalloc()
  Delete an unnecessary variable initialisation

 arch/powerpc/sysdev/axonram.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

-- 
2.13.4
