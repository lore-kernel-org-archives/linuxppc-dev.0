Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B40C48BE6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 07:36:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D2F6044F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 07:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D2F6044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4cSL5Cs8z3bV0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 17:36:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=rong.a.chen@intel.com; receiver=<UNKNOWN>)
X-Greylist: delayed 64 seconds by postgrey-1.36 at boromir;
 Wed, 16 Jun 2021 17:35:58 AEST
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4cRy2y2Zz2yXJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 17:35:58 +1000 (AEST)
IronPort-SDR: kCLF0/6Vebqycs20r/z+4+c7jnHX+UtfQPc7XJlzn83cDlR6DctnMXHO5fy3oTh9cUMBC0I7WZ
 EtMbgVBF9YcA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="269981010"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; d="scan'208";a="269981010"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 00:34:40 -0700
IronPort-SDR: tju26XTtT5CtSiJa+42+6hw9m/hu3AjlCFfT8dthm9xR7YXfatXk2vYbm04LaUuF5xQNWhDGwk
 ZjnaFeczxSqA==
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; d="scan'208";a="484782709"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 00:34:35 -0700
Date: Wed, 16 Jun 2021 15:34:32 +0800
From: kernel test robot <rong.a.chen@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: [powerpc:next-test 113/124] arch/powerpc/kernel/interrupt_64.S:
 asm/head-64.h is included more than once.
Message-ID: <20210616073432.GX237458@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: kbuild-all@lists.01.org, Palmer Dabbelt <palmerdabbelt@google.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sandipan Das <sandipan@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
head:   103bf32b0d2dd8b8a4d3d9ebdded5ba4e8263e6a
commit: 5592c877d21b6ca201aafca349663c5a41f134f0 [113/124] powerpc/64: move interrupt return asm to interrupt_64.S
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/powerpc/kernel/interrupt_64.S: asm/head-64.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
