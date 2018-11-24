Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8622C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 08:54:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1112086B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 08:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1112086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4326Rn3px0zDqVq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 19:54:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=philip.li@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4326PW023FzDqV9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 19:52:04 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Nov 2018 00:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,273,1539673200"; d="scan'208";a="110730850"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.153])
 by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2018 00:51:58 -0800
Date: Sat, 24 Nov 2018 17:04:44 +0800
From: Philip Li <philip.li@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: dad4f140ed ("Merge branch 'xarray' of .."):  Mem-Info:
Message-ID: <20181124090444.GA3141@intel.com>
References: <5bf8a766.2eiLO6qApoh2dO55%lkp@intel.com>
 <20181124035803.GX3065@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124035803.GX3065@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: kernel test robot <lkp@intel.com>, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 intel-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-input@vger.kernel.org, linux-fsdevel@vger.kernel.org, LKP <lkp@01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 23, 2018 at 07:58:03PM -0800, Matthew Wilcox wrote:
> On Sat, Nov 24, 2018 at 09:20:38AM +0800, kernel test robot wrote:
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > commit dad4f140edaa3f6bb452b6913d41af1ffd672e45
> 
> I think you've got the wrong bisection point, confused by other messages.
> Here's the messages I think you intend to chase:
> 
> [  155.389297] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck
>  for 52s!
> [  155.409004] BUG: workqueue lockup - pool cpus=0 flags=0x4 nice=0 stuck for 40
> s!
> [  155.420377] Showing busy workqueues and worker pools:
> [  155.428445] workqueue events: flags=0x0
> [  155.434634]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
> [  155.437904]     pending: cache_reap
> [  155.449671] workqueue events_power_efficient: flags=0x82
> [  155.458000]   pwq 2: cpus=0 flags=0x4 nice=0 active=3/256
> [  155.461269]     pending: neigh_periodic_work, do_cache_clean, check_lifetime
> 
> 
> but you're getting hung up on the testsuite problems.
thanks for pointing out this. Kindly ignore this report, which is false positive.

> 
> 
