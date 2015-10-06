Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D97041A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 14:39:07 +1100 (AEDT)
Message-ID: <1444102746.16909.4.camel@ellerman.id.au>
Subject: Re: [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
From: Michael Ellerman <mpe@ellerman.id.au>
To: kbuild test robot <lkp@intel.com>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, kbuild-all@01.org,
 Matthew Wilcox <willy@linux.intel.com>, Keith Busch
 <keith.busch@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, Christoph Hellwig
 <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Oct 2015 14:39:06 +1100
In-Reply-To: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-10-03 at 04:33 +0800, kbuild test robot wrote:
> Hi Nishanth,
> 
> [auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]
> 
> config: powerpc-defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    arch/powerpc/platforms/pseries/iommu.c: In function 'iommu_init_early_pSeries':
> >> arch/powerpc/platforms/pseries/iommu.c:1433:9: error: 'struct machdep_calls' has no member named 'dma_get_page_shift'
>       ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;

It was added in patch 3/5, so I think this error is bogus. Unless there's a
typo I'm missing?

cheers
