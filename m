Return-Path: <fengguang.wu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w989m63pxzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 20:34:34 +1000 (AEST)
Date: Sat, 22 Apr 2017 18:34:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: use ibm,
 tlbiel-congruence-classes-(hash|radix) dt property
Message-ID: <201704221858.WsgLKAYe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
In-Reply-To: <20170422005854.17128-2-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

[auto build test ERROR on powerpc/next]
[also build test ERROR on next-20170421]
[cannot apply to v4.11-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-64s-use-ibm-tlbiel-congruence-classes-hash-radix-dt-property/20170422-164227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/prom.c: In function 'early_init_dt_scan_cpus':
>> arch/powerpc/kernel/prom.c:407:2: error: implicit declaration of function 'init_mmu_tlb_sets_hash' [-Werror=implicit-function-declaration]
     init_mmu_tlb_sets_hash(node);
     ^~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/prom.c:408:2: error: implicit declaration of function 'init_mmu_tlb_sets_radix' [-Werror=implicit-function-declaration]
     init_mmu_tlb_sets_radix(node);
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/init_mmu_tlb_sets_hash +407 arch/powerpc/kernel/prom.c

   401	
   402		identical_pvr_fixup(node);
   403	
   404		check_cpu_feature_properties(node);
   405		check_cpu_pa_features(node);
   406		init_mmu_slb_size(node);
 > 407		init_mmu_tlb_sets_hash(node);
 > 408		init_mmu_tlb_sets_radix(node);
   409	
   410	#ifdef CONFIG_PPC64
   411		if (nthreads > 1)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vkogqOf2sHV7VnPd--
