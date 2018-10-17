Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FD8ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 10:09:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FCA2150D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 10:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FCA2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Znwb40HVzF3ZH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:09:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZntP33W2zF3HS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 21:07:56 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Oct 2018 03:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
 d="gz'50?scan'50,208,50";a="83289733"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 17 Oct 2018 03:07:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gCik3-000HMd-Ri; Wed, 17 Oct 2018 18:07:51 +0800
Date: Wed, 17 Oct 2018 18:07:04 +0800
From: kbuild test robot <lkp@intel.com>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH 1/5] powerpc/64s: Kernel Hypervisor Restricted Access
 Prevention
Message-ID: <201810171821.TOPFrPj5%fengguang.wu@intel.com>
References: <20181017064422.26119-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20181017064422.26119-1-ruscur@russell.cc>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on next-20181016]
[cannot apply to v4.19-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Russell-Currey/powerpc-64s-Kernel-Hypervisor-Restricted-Access-Prevention/20181017-153543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-storcenter_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:14:0,
                    from net/core/datagram.c:40:
   arch/powerpc/include/asm/uaccess.h: In function 'unlock_user_access':
>> arch/powerpc/include/asm/uaccess.h:69:6: error: implicit declaration of function 'mmu_has_feature'; did you mean 'firmware_has_feature'? [-Werror=implicit-function-declaration]
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
         ^~~~~~~~~~~~~~~
         firmware_has_feature
>> arch/powerpc/include/asm/uaccess.h:69:22: error: 'MMU_FTR_RADIX_KHRAP' undeclared (first use in this function); did you mean 'CPU_FTR_CAN_NAP'?
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
                         ^~~~~~~~~~~~~~~~~~~
                         CPU_FTR_CAN_NAP
   arch/powerpc/include/asm/uaccess.h:69:22: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/include/asm/uaccess.h: In function 'lock_user_access':
   arch/powerpc/include/asm/uaccess.h:83:22: error: 'MMU_FTR_RADIX_KHRAP' undeclared (first use in this function); did you mean 'CPU_FTR_CAN_NAP'?
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
                         ^~~~~~~~~~~~~~~~~~~
                         CPU_FTR_CAN_NAP
   In file included from include/linux/mm_types.h:18:0,
                    from include/linux/mm.h:17,
                    from net/core/datagram.c:41:
   arch/powerpc/include/asm/mmu.h: At top level:
>> arch/powerpc/include/asm/mmu.h:209:20: error: conflicting types for 'mmu_has_feature'
    static inline bool mmu_has_feature(unsigned long feature)
                       ^~~~~~~~~~~~~~~
   In file included from include/linux/uaccess.h:14:0,
                    from net/core/datagram.c:40:
   arch/powerpc/include/asm/uaccess.h:69:6: note: previous implicit declaration of 'mmu_has_feature' was here
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
         ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/uaccess.h:14:0,
                    from include/linux/crypto.h:26,
                    from include/crypto/skcipher.h:16,
                    from include/crypto/chacha20.h:9,
                    from lib/chacha20.c:17:
   arch/powerpc/include/asm/uaccess.h: In function 'unlock_user_access':
>> arch/powerpc/include/asm/uaccess.h:69:6: error: implicit declaration of function 'mmu_has_feature'; did you mean 'firmware_has_feature'? [-Werror=implicit-function-declaration]
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
         ^~~~~~~~~~~~~~~
         firmware_has_feature
>> arch/powerpc/include/asm/uaccess.h:69:22: error: 'MMU_FTR_RADIX_KHRAP' undeclared (first use in this function); did you mean 'CPU_FTR_CAN_NAP'?
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
                         ^~~~~~~~~~~~~~~~~~~
                         CPU_FTR_CAN_NAP
   arch/powerpc/include/asm/uaccess.h:69:22: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/include/asm/uaccess.h: In function 'lock_user_access':
   arch/powerpc/include/asm/uaccess.h:83:22: error: 'MMU_FTR_RADIX_KHRAP' undeclared (first use in this function); did you mean 'CPU_FTR_CAN_NAP'?
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
                         ^~~~~~~~~~~~~~~~~~~
                         CPU_FTR_CAN_NAP
   cc1: some warnings being treated as errors
--
   In file included from include/linux/uaccess.h:14:0,
                    from arch/powerpc/kernel/module.c:25:
   arch/powerpc/include/asm/uaccess.h: In function 'unlock_user_access':
>> arch/powerpc/include/asm/uaccess.h:69:6: error: implicit declaration of function 'mmu_has_feature'; did you mean 'firmware_has_feature'? [-Werror=implicit-function-declaration]
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
         ^~~~~~~~~~~~~~~
         firmware_has_feature
>> arch/powerpc/include/asm/uaccess.h:69:22: error: 'MMU_FTR_RADIX_KHRAP' undeclared (first use in this function); did you mean 'CPU_FTR_CAN_NAP'?
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
                         ^~~~~~~~~~~~~~~~~~~
                         CPU_FTR_CAN_NAP
   arch/powerpc/include/asm/uaccess.h:69:22: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/include/asm/uaccess.h: In function 'lock_user_access':
   arch/powerpc/include/asm/uaccess.h:83:22: error: 'MMU_FTR_RADIX_KHRAP' undeclared (first use in this function); did you mean 'CPU_FTR_CAN_NAP'?
     if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
                         ^~~~~~~~~~~~~~~~~~~
                         CPU_FTR_CAN_NAP
   cc1: all warnings being treated as errors

vim +69 arch/powerpc/include/asm/uaccess.h

    64	
    65	static inline unsigned long unlock_user_access(void)
    66	{
    67		unsigned long amr;
    68	
  > 69		if (mmu_has_feature(MMU_FTR_RADIX_KHRAP)) {
    70			amr = mfspr(SPRN_AMR);
    71	
    72			isync();
    73			mtspr(SPRN_AMR, 0);
    74			isync();
    75			return amr;
    76		}
    77	
    78		return 0;
    79	}
    80	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
L675IVA9x/Gj/w8kcsgLhu8AAA==

--CE+1k2dSO48ffgeK--
