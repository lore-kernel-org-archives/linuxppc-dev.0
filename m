Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92CF01A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 07:32:02 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: kbuild test robot <lkp@intel.com>, Alessandro Zummo <a.zummo@towertech.it>,
 linux-parisc@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kyle McMartin <kyle@mcmartin.ca>, linux-m68k@lists.linux-m68k.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>, kbuild-all@01.org,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] powerpc: rtc: provide rtc_class_ops directly
Date: Tue, 01 Mar 2016 21:31:09 +0100
Message-ID: <43764978.ST0U01oqaW@wuerfel>
In-Reply-To: <201603020228.jios50eU%fengguang.wu@intel.com>
References: <201603020228.jios50eU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 02 March 2016 02:37:14 kbuild test robot wrote:
> [auto build test ERROR on abelloni/rtc-next]
> [also build test ERROR on v4.5-rc6 next-20160301]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/rtc-generic-follow-up-for-COMPILE_TEST/20160302-011032
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> config: powerpc-allnoconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/built-in.o: In function `rtc_generic_get_time':
> >> time.c:(.text+0x4c58): undefined reference to `rtc_valid_tm'
> 

I fixed up the powerpc and parisc patches now, will resend them
after getting some feedback on the overall approach.

	Arnd
