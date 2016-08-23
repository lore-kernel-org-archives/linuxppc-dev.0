Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJBSs4sJgzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 10:41:17 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id ez1so8877413pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:41:17 -0700 (PDT)
Message-ID: <1471912867.758.15.camel@gmail.com>
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
From: Cyril Bur <cyrilbur@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org,  mikey@neuling.org, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, Simon Guo <wei.guo.simon@gmail.com>
Date: Tue, 23 Aug 2016 10:41:07 +1000
In-Reply-To: <201608221942.egSVXMlz%fengguang.wu@intel.com>
References: <201608221942.egSVXMlz%fengguang.wu@intel.com>
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

On Mon, 2016-08-22 at 19:21 +0800, kbuild test robot wrote:
> Hi Cyril,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.8-rc3 next-20160822]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --
> base=auto for convenience) to record what (public, well-known) commit
> your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more
> information]
> 
> url:    https://github.com/0day-ci/linux/commits/Cyril-Bur/powerpc-si
> gnals-Discard-transaction-state-from-signal-frames/20160822-131843
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> .git next
> config: powerpc-g5_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tes
> ts.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/built-in.o: In function
> `.compat_sys_rt_sigreturn':
> > 
> > > 
> > > (.text+0x5d64): undefined reference to `.tm_reclaim_current'
>    arch/powerpc/kernel/built-in.o: In function `.sys_rt_sigreturn':
>    (.text+0x140a4): undefined reference to `.tm_reclaim_current'
> 

For the record, I don't seem to be able to reproduce this. I tried a
variety of configs including the attached one and g5_defconfig and
cannot see this.

GCC 4.9.3, 5.3.0 and 6.1.0 used with powerpc/next and v4.8.0-rc3


> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
