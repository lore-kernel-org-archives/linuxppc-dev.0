Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7ABC004D3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756B0205F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756B0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42f39l4Sr1zF36x
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 04:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42f37N1bXfzF2QM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 04:15:25 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2018 10:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,412,1534834800"; 
 d="gz'50?scan'50,208,50";a="83507245"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 22 Oct 2018 10:15:18 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gEdnS-0007iS-Ex; Tue, 23 Oct 2018 01:15:18 +0800
Date: Tue, 23 Oct 2018 01:14:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v9 2/7] dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT
 implement for ARM platform
Message-ID: <201810230103.1SquAJF2%fengguang.wu@intel.com>
References: <20181017055957.542-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20181017055957.542-2-peng.ma@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, zw@zh-kernel.org,
 vkoul@kernel.org, robh+dt@kernel.org, kbuild-all@01.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux-sof-driver/master]
[also build test WARNING on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peng-Ma/dmaengine-fsldma-Replace-DMA_IN-OUT-by-FSL_DMA_IN-OUT/20181017-232444
base:   https://github.com/thesofproject/linux master
config: powerpc-xes_mpc85xx_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h: In function 'fsl_ioread64':
>> drivers/dma/fsldma.h:210:17: warning: passing argument 1 of 'in_le32' makes pointer from integer without a cast [-Wint-conversion]
     return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
                    ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:172:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_X(in_le32, 32, lwbrx);
                  ^
   arch/powerpc/include/asm/io.h:131:23: note: in definition of macro 'DEF_MMIO_IN_X'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h:210:37: warning: passing argument 1 of 'in_le32' makes pointer from integer without a cast [-Wint-conversion]
     return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
                                        ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:172:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_X(in_le32, 32, lwbrx);
                  ^
   arch/powerpc/include/asm/io.h:131:23: note: in definition of macro 'DEF_MMIO_IN_X'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
>> drivers/dma/fsldma.h:210:51: warning: left shift count >= width of type [-Wshift-count-overflow]
     return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
                                                      ^~
   drivers/dma/fsldma.h: In function 'fsl_ioread64be':
>> drivers/dma/fsldma.h:223:17: warning: passing argument 1 of 'in_be32' makes pointer from integer without a cast [-Wint-conversion]
     return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
                    ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:170:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_D(in_be32, 32, lwz);
                  ^
   arch/powerpc/include/asm/io.h:149:23: note: in definition of macro 'DEF_MMIO_IN_D'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h:223:41: warning: passing argument 1 of 'in_be32' makes pointer from integer without a cast [-Wint-conversion]
     return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
                                            ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:170:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_D(in_be32, 32, lwz);
                  ^
   arch/powerpc/include/asm/io.h:149:23: note: in definition of macro 'DEF_MMIO_IN_D'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h:223:51: warning: left shift count >= width of type [-Wshift-count-overflow]
     return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
                                                      ^~

vim +/in_le32 +210 drivers/dma/fsldma.h

   204	
   205	#ifndef __powerpc64__
   206	static u64 fsl_ioread64(const u64 __iomem *addr)
   207	{
   208		u32 fsl_addr = lower_32_bits(addr);
   209	
 > 210		return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
   211	}
   212	
   213	static void fsl_iowrite64(u64 val, u64 __iomem *addr)
   214	{
   215		out_le32((u32 __iomem *)addr + 1, val >> 32);
   216		out_le32((u32 __iomem *)addr, (u32)val);
   217	}
   218	
   219	static u64 fsl_ioread64be(const u64 __iomem *addr)
   220	{
   221		u32 fsl_addr = lower_32_bits(addr);
   222	
 > 223		return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
   224	}
   225	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
MMZBDe+7GyQk+n8MGVB0IyUBAA==

--ZPt4rx8FFjLCG7dd--
