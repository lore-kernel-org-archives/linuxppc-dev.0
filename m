Return-Path: <shuah.khan@hp.com>
Received: from g4t0014.houston.hp.com (g4t0014.houston.hp.com [15.201.24.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E7B802C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2012 08:37:12 +1100 (EST)
Message-ID: <1353706142.5270.93.camel@lorien2>
Subject: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
From: Shuah Khan <shuah.khan@hp.com>
To: Joerg Roedel <joro@8bytes.org>, a-jacquiot@ti.com, fenghua.yu@intel.com,
 catalin.marinas@arm.com, lethal@linux-sh.org, benh@kernel.crashing.org,
 ralf@linux-mips.org, tony.luck@intel.com, davem@davemloft.net,
 m.szyprowski@samsung.com, msalter@redhat.com, monstr@monstr.eu, Ming Lei
 <ming.lei@canonical.com>
Date: Fri, 23 Nov 2012 14:29:02 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, LKML <linux-kernel@vger.kernel.org>,
 shuahkhan@gmail.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: shuah.khan@hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An earlier patch added dma mapping error debug feature to dma_debug
infrastructure. References:

https://lkml.org/lkml/2012/10/8/296
https://lkml.org/lkml/2012/11/3/219

The following series of patches adds the call to debug_dma_mapping_error() to
architecture specific dma_mapping_error() interfaces on the following
architectures that support CONFIG_DMA_API_DEBUG.

arm64
c6x
ia64
microblaze
mips
powerpc
sh
sparc
tile

arm - Change is already in Marek's dma-mapping tree[1] 
https://patchwork.kernel.org/patch/1625601/

microblaze - Change is already in linux-next. Including it for completeness
linux-next commit f229605441030bcd315c21d97b25889d63ed0130

x86 - done in the first patch that added the feature.

ARM64: dma_debug: add debug_dma_mapping_error support
c6x: dma_debug: add debug_dma_mapping_error support
ia64: dma_debug: add debug_dma_mapping_error support
microblaze: dma-mapping: support debug_dma_mapping_error
mips: dma_debug: add debug_dma_mapping_error support
powerpc: dma_debug: add debug_dma_mapping_error support
sh: dma_debug: add debug_dma_mapping_error support
sparc: dma_debug: add debug_dma_mapping_error support
tile: dma_debug: add debug_dma_mapping_error support

Thanks,
-- Shuah
