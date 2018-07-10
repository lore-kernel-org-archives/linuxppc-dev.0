Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Q3gQ5xSqzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 23:57:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: kbuild test robot <lkp@intel.com>, Daniel Klamt <eleon@ele0n.de>
Cc: kbuild-all@01.org, benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kernel@i4.cs.fau.de, Daniel Klamt <eleon@ele0n.de>,
 Bjoern Noetel <bjoern@br3ak3r.de>
Subject: Re: [PATCH] powerpc: Replaced msleep with usleep_range
In-Reply-To: <201807100423.0p0r9QGb%fengguang.wu@intel.com>
References: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
 <201807100423.0p0r9QGb%fengguang.wu@intel.com>
Date: Tue, 10 Jul 2018 23:57:51 +1000
Message-ID: <87y3ej9ork.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kbuild test robot <lkp@intel.com> writes:

> Hi Daniel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.18-rc4 next-20180709]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Daniel-Klamt/powerpc-Replaced-msleep-with-usleep_range/20180709-231913
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/sysdev/xive/native.c: In function 'xive_native_configure_irq':
>>> arch/powerpc/sysdev/xive/native.c:113:2: error: expected ';' before '}' token
>      }
>      ^

There's also instructions here for building the powerpc kernel:

  https://github.com/linuxppc/linux/wiki/Building-powerpc-kernels

cheers
