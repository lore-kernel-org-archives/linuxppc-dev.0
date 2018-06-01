Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 40xxpd3vnSzDrp0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 18:10:33 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel 0/2] powerpc/powernv: Rework sketchy bypass
Date: Fri,  1 Jun 2018 18:10:26 +1000
Message-Id: <20180601081028.29401-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I came across this adhoc implementation and thought it could use some
polishing. This fixes memory leaks and add P9 support. Based on the current
upstream.


Please comment. Thanks.



Alexey Kardashevskiy (2):
  powerpc/powernv: Reuse existing TCE code for sketchy bypass
  powerpc/powernv: Define PHB4 type and enable sketchy bypass on POWER9

 arch/powerpc/platforms/powernv/pci.h      |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 76 +++++++++++++++++--------------
 2 files changed, 44 insertions(+), 33 deletions(-)

-- 
2.11.0
