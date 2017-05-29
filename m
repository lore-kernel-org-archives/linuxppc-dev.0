Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc8nj4kWLzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 07:22:01 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
 mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/3] EDAC: mv64x60: updates
Date: Tue, 30 May 2017 09:21:39 +1200
Message-Id: <20170529212142.25572-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm looking at making use of the mv64x60_edac driver for the armada processors.
It appears that at least the DRAM ECC error reporting is the same block from
the old Marvell Discovery class of processors. On the ARM side I need to get
the error interrupts exposed first before I can send my second set of changes
for this driver but this first set is just a series of cleanups.

Chris Packham (3):
  EDAC: mv64x60: check driver registration success
  EDAC: mv64x60: Fix pdata->name
  EDAC: mv64x60: replace in_le32/out_le32 with readl/writel

 drivers/edac/mv64x60_edac.c | 94 +++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

-- 
2.13.0
