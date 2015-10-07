Return-Path: <lkp@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 7003B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 00:56:18 +1100 (AEDT)
Date: Wed, 7 Oct 2015 21:56:02 +0800
From: Fengguang Wu <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christoph Hellwig <hch@infradead.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>,
 Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 Matthew Wilcox <willy@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kbuild-all] [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
Message-ID: <20151007135602.GA17377@wfg-t540p.sh.intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444102746.16909.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06, 2015 at 02:39:06PM +1100, Michael Ellerman wrote:
> On Sat, 2015-10-03 at 04:33 +0800, kbuild test robot wrote:
> > Hi Nishanth,
> > 
> > [auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]
> > 
> > config: powerpc-defconfig (attached as .config)
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=powerpc 
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    arch/powerpc/platforms/pseries/iommu.c: In function 'iommu_init_early_pSeries':
> > >> arch/powerpc/platforms/pseries/iommu.c:1433:9: error: 'struct machdep_calls' has no member named 'dma_get_page_shift'
> >       ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;
> 
> It was added in patch 3/5, so I think this error is bogus. Unless there's a
> typo I'm missing?

Yes sorry, the patchset was not detected correctly in your case,
ending up the patches being tested as individual ones.

I'll fixup the robot.

Thanks,
Fengguang
