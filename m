Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E1C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 05:39:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4863820811
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 05:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4863820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43F5GC6gpszDqcq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 16:38:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F5D45MlJzDqsX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 16:37:05 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Dec 2018 21:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
 d="gz'50?scan'50,208,50";a="258781609"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 11 Dec 2018 21:37:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gWxCe-0002bW-TS; Wed, 12 Dec 2018 13:37:00 +0800
Date: Wed, 12 Dec 2018 13:36:24 +0800
From: kbuild test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [powerpc:next-test 70/71] include/asm-generic/memory_model.h:55:54:
 error: 'vmemmap' undeclared; did you mean 'mem_map'?
Message-ID: <201812121310.MnbC0L9L%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
head:   13fd174be1903cc069bb73b0d53a0420b8f6d778
commit: 3a0f466ce2402cc090c97ccc1285508f688d8a8e [70/71] powerpc: Implement CONFIG_DEBUG_VIRTUAL
config: powerpc-ppc64e_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3a0f466ce2402cc090c97ccc1285508f688d8a8e
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/page.h:339:0,
                    from arch/powerpc/include/asm/thread_info.h:29,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from init/do_mounts.c:1:
   arch/powerpc/include/asm/io.h: In function 'page_to_phys':
>> include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'mem_map'?
    #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
                                                         ^
   include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
    #define page_to_pfn __page_to_pfn
                        ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
     unsigned long pfn = page_to_pfn(page);
                         ^~~~~~~~~~~
   include/asm-generic/memory_model.h:55:54: note: each undeclared identifier is reported only once for each function it appears in
    #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
                                                         ^
   include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
    #define page_to_pfn __page_to_pfn
                        ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:835:22: note: in expansion of macro 'page_to_pfn'
     unsigned long pfn = page_to_pfn(page);
                         ^~~~~~~~~~~

vim +55 include/asm-generic/memory_model.h

8f6aac41 Christoph Lameter  2007-10-16  52  
af901ca1 André Goddard Rosa 2009-11-14  53  /* memmap is virtually contiguous.  */
8f6aac41 Christoph Lameter  2007-10-16  54  #define __pfn_to_page(pfn)	(vmemmap + (pfn))
32272a26 Martin Schwidefsky 2008-12-25 @55  #define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
8f6aac41 Christoph Lameter  2007-10-16  56  

:::::: The code at line 55 was first introduced by commit
:::::: 32272a26974d2027384fd4010cd1780fca425d94 [S390] __page_to_pfn warnings

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--qMm9M+Fa2AknHoGS--
