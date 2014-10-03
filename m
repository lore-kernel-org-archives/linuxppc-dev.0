Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 854AF1A1835
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 22:56:14 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Mark Brown <broonie@kernel.org>,
 Marcelo Tosatti <marcelo@kvack.org>, Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 0/2] fsl: fsl-spi: Fix CMP1 pram allocation and allow dynamic
 allocation
Message-Id: <20141003125608.A3E7E1AB274@localhost.localdomain>
Date: Fri,  3 Oct 2014 14:56:08 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset:
1) Fix parameter ram offset setup for CPM1
2) Allow dynamic allocation of CPM1 parameter RAM

Tested on MPC885.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 linux/arch/powerpc/platforms/8xx/Kconfig | 11 +++++++++++
 linux/drivers/spi/spi-fsl-cpm.c          | 14 +++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)
