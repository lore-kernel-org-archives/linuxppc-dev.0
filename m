Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5044C43143
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 02:18:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFB920685
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 02:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFB920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42N8H171MVzF3BQ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 12:18:53 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42N8Ds6bglzF3C8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 12:17:00 +1000 (AEST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Sep 2018 19:16:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,322,1534834800"; 
 d="gz'50?scan'50,208,50";a="96133514"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 29 Sep 2018 19:16:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1g6RHy-0005w2-QG; Sun, 30 Sep 2018 10:16:54 +0800
Date: Sun, 30 Sep 2018 10:16:24 +0800
From: kbuild test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 1/2] powerpc/32: add stack protector support
Message-ID: <201809301023.o5oGJmtR%fengguang.wu@intel.com>
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christophe,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.19-rc5 next-20180928]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc-32-add-stack-protector-support/20180926-123625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-mpc86xx_basic_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_add_display_props.isra.1':
>> bootx_init.c:(.init.text+0x504): undefined reference to `__stack_chk_fail_local'
   arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_scan_dt_build_struct':
   bootx_init.c:(.init.text+0x820): undefined reference to `__stack_chk_fail_local'
   arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_init':
   bootx_init.c:(.init.text+0xbbc): undefined reference to `__stack_chk_fail_local'
   powerpc-linux-gnu-ld: .tmp_vmlinux1: hidden symbol `__stack_chk_fail_local' isn't defined
   powerpc-linux-gnu-ld: final link failed: Bad value

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--DocE+STaALJfprDB--
