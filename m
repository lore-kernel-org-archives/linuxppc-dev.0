Return-Path: <fengguang.wu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40845L1twfzF1vl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 15:28:02 +1100 (AEDT)
Date: Sun, 25 Mar 2018 12:27:52 +0800
From: kbuild test robot <lkp@intel.com>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: kbuild-all@01.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/6] libnvdimm: Add device-tree based driver
Message-ID: <201803251241.H0O3ZUaT%fengguang.wu@intel.com>
References: <20180323081209.31387-3-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180323081209.31387-3-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Oliver,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linux-nvdimm/libnvdimm-for-next]
[also build test WARNING on v4.16-rc6 next-20180323]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oliver-O-Halloran/libnvdimm-Add-of_node-to-region-and-bus-descriptors/20180325-082036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/nvdimm/of_nvdimm.c:18:30: sparse: symbol 'bus_desc' was not declared. Should it be static?
   drivers/nvdimm/of_nvdimm.c:19:19: sparse: symbol 'bus' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
