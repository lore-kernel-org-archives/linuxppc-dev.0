Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNdXk4MWKzDvwr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 08:15:18 +1100 (AEDT)
Date: Wed, 23 Nov 2016 08:15:14 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kbuild test robot <lkp@intel.com>, linuxppc-dev@ozlabs.org,
 kbuild-all@01.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] powerpc/64: Provide functions for accessing POWER9
 partition table
Message-ID: <20161122211514.GA6487@fergus.ozlabs.ibm.com>
References: <201611211551.D3xry2wx%fengguang.wu@intel.com>
 <87k2bvvkwl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k2bvvkwl.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2016 at 10:00:58PM +1100, Michael Ellerman wrote:
> kbuild test robot <lkp@intel.com> writes:
> > [auto build test WARNING on powerpc/next]
> > [cannot apply to v4.9-rc6 next-20161117]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Paul-Mackerras/powerpc-64-Preparation-for-KVM-support-on-POWER9/20161121-133431
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> > config: powerpc-allyesconfig (attached as .config)
> > compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=powerpc 
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> WARNING: vmlinux.o(.text+0x5c650): Section mismatch in reference from the function .mmu_partition_table_init() to the function .init.text:.memblock_alloc_base()
> >    The function .mmu_partition_table_init() references
> >    the function __init .memblock_alloc_base().
> 
> >    This is often because .mmu_partition_table_init lacks a __init
> 
> Indeed that looks like the problem.
> 
> Paul have you already merged the topic branch, or can I squash in a fix
> for this? Or I'll just do it on top.

I haven't pushed out the merge, so go ahead.

Paul.
