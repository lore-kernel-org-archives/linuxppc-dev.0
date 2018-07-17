Return-Path: <lkp@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41V1yW31kBzF35w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 10:54:41 +1000 (AEST)
Date: Tue, 17 Jul 2018 09:05:43 +0800
From: kbuild test robot <lkp@intel.com>
To: Diana Craciun <diana.craciun@nxp.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, oss@buserror.net,
 Diana Craciun <diana.craciun@nxp.com>, bharat.bhushan@nxp.com,
 leoyang.li@nxp.com
Subject: Re: [PATCH v3 5/6] powerpc/fsl: Add barrier_nospec implementation
 for NXP PowerPC Book3E
Message-ID: <20180717010543.GI10593@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFBW6CQlri5Qm8JQ"
In-Reply-To: <1531489935-17473-6-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Diana,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.18-rc5 next-20180713]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Diana-Craciun/powerpc-fsl-Disable-the-speculation-barrier-from-the-command-line/20180714-130716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-bluestone_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/cputable.o: In function `setup_barrier_nospec':
>> cputable.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/irq.o: In function `setup_barrier_nospec':
   irq.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/vdso.o: In function `setup_barrier_nospec':
   vdso.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/process.o: In function `setup_barrier_nospec':
   process.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/idle.o: In function `setup_barrier_nospec':
   idle.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/sysfs.o: In function `setup_barrier_nospec':
   sysfs.c:(.text+0x98): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/time.o: In function `setup_barrier_nospec':
   time.c:(.text+0x14c): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/prom.o: In function `setup_barrier_nospec':
   prom.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/traps.o: In function `setup_barrier_nospec':
   traps.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/setup-common.o: In function `setup_barrier_nospec':
   setup-common.c:(.text+0x428): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/dma.o: In function `setup_barrier_nospec':
   dma.c:(.text+0x3dc): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/of_platform.o: In function `setup_barrier_nospec':
   of_platform.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/proc_powerpc.o: In function `setup_barrier_nospec':
   proc_powerpc.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/setup_32.o: In function `setup_barrier_nospec':
   setup_32.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/legacy_serial.o: In function `setup_barrier_nospec':
   legacy_serial.c:(.text+0x90): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/pci_32.o: In function `setup_barrier_nospec':
   pci_32.c:(.text+0x1c8): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/pci-common.o: In function `setup_barrier_nospec':
   pci-common.c:(.text+0x61c): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/pci_of_scan.o: In function `setup_barrier_nospec':
   pci_of_scan.c:(.text+0x4c): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/msi.o: In function `setup_barrier_nospec':
   msi.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/kernel/iomap.o: In function `setup_barrier_nospec':
   iomap.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/mm/mem.o: In function `setup_barrier_nospec':
   mem.c:(.text+0x18): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/mm/init_32.o: In function `setup_barrier_nospec':
   init_32.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/mm/pgtable_32.o: In function `setup_barrier_nospec':
   pgtable_32.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/mm/hugetlbpage.o: In function `setup_barrier_nospec':
   hugetlbpage.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/lib/alloc.o: In function `setup_barrier_nospec':
   alloc.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/lib/code-patching.o: In function `setup_barrier_nospec':
   code-patching.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/lib/feature-fixups.o: In function `setup_barrier_nospec':
   feature-fixups.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/sysdev/msi_bitmap.o: In function `setup_barrier_nospec':
   msi_bitmap.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/sysdev/indirect_pci.o: In function `setup_barrier_nospec':
   indirect_pci.c:(.text+0x220): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/platforms/4xx/pci.o: In function `setup_barrier_nospec':
   pci.c:(.text+0x954): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/platforms/4xx/msi.o: In function `setup_barrier_nospec':
   msi.c:(.text+0x6d0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/platforms/4xx/cpm.o: In function `setup_barrier_nospec':
   cpm.c:(.text+0x410): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   arch/powerpc/platforms/44x/ppc44x_simple.o: In function `setup_barrier_nospec':
   ppc44x_simple.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here
   block/blk-mq-pci.o: In function `setup_barrier_nospec':
   blk-mq-pci.c:(.text+0x0): multiple definition of `setup_barrier_nospec'
   init/main.o:main.c:(.text+0x9c): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--nFBW6CQlri5Qm8JQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--nFBW6CQlri5Qm8JQ--
