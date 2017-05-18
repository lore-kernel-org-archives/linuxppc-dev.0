Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT4QX67LfzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:40:52 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	mchehab@kernel.org,
	linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/3] EDAC: mv64x60: updates
Date: Thu, 18 May 2017 20:31:32 +1200
Message-Id: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
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
  EDAC: mv64x60: remove unused variable
  EDAC: mv64x60: Fix pdata->name
  EDAC: mv64x60: replace in_le32/out_le32 with readl/writel

 drivers/edac/mv64x60_edac.c | 88 ++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

-- 
2.11.0.24.ge6920cf
