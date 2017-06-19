Return-Path: <fengguang.wu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrb4225HWzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 12:47:29 +1000 (AEST)
Date: Mon, 19 Jun 2017 10:46:19 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Sahil Mehta <sahilmehta17@gmail.com>,
 Rashmica Gupta <rashmicy@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V5 2/2] powerpc/numa: Update CPU topology when VPHN enabled
Message-ID: <201706191026.jZKxb16H%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <a98d9a2c-03e5-a078-0b1b-7f7da2cc8669@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.12-rc5 next-20170616]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michael-Bringmann/powerpc-dlpar-Correct-display-of-hot-add-hot-remove-CPUs-and-memory/20170619-081809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-ksi8560_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/topology.h:35:0,
                    from include/linux/gfp.h:8,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/of.h:21,
                    from include/linux/irqdomain.h:34,
                    from arch/powerpc/include/asm/irq.h:12,
                    from arch/powerpc/include/asm/prom.h:19,
                    from arch/powerpc/kernel/cputable.c:22:
>> arch/powerpc/include/asm/topology.h:76:12: error: 'timed_topology_update' defined but not used [-Werror=unused-function]
    static int timed_topology_update(int nsecs)
               ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/timed_topology_update +76 arch/powerpc/include/asm/topology.h

    70		return 0;
    71	}
    72	static inline int stop_topology_update(void)
    73	{
    74		return 0;
    75	}
  > 76	static int timed_topology_update(int nsecs)
    77	{
    78		return 0;
    79	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--d6Gm4EdcadzBjdND--
