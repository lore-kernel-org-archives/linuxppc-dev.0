Return-Path: <fengguang.wu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id B18611A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 05:38:22 +1100 (AEDT)
Date: Wed, 2 Mar 2016 02:37:14 +0800
From: kbuild test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-arm-kernel@lists.infradead.org,
 Kyle McMartin <kyle@mcmartin.ca>, rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] powerpc: rtc: provide rtc_class_ops directly
Message-ID: <201603020228.jios50eU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
In-Reply-To: <1456851608-3374907-4-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.5-rc6 next-20160301]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/rtc-generic-follow-up-for-COMPILE_TEST/20160302-011032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: powerpc-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/built-in.o: In function `rtc_generic_get_time':
>> time.c:(.text+0x4c58): undefined reference to `rtc_valid_tm'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--X1bOJ3K7DJ5YkBrT
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--X1bOJ3K7DJ5YkBrT--
