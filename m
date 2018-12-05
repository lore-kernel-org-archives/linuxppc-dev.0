Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E990EC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 11:23:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C2B20659
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C2B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438xF473QGzDqS3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 22:23:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 438xB31WMkzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 22:20:57 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4D6A80D;
 Wed,  5 Dec 2018 03:20:54 -0800 (PST)
Received: from [10.1.34.157] (p8cg001049571a15.cambridge.arm.com [10.1.34.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A6A93F575;
 Wed,  5 Dec 2018 03:20:51 -0800 (PST)
Subject: Re: [LKP] [mm] 19717e78a0: stderr.if(target_node==NUMA_NO_NODE){
To: kernel test robot <rong.a.chen@intel.com>
References: <20181205050057.GB23332@shao2-debian>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d75d097f-78a5-865e-a80a-b1e6faeff337@arm.com>
Date: Wed, 5 Dec 2018 16:50:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205050057.GB23332@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: hverkuil@xs4all.nl, linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
 vkoul@kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, intel-wired-lan@lists.osuosl.org, lkp@01.org,
 linux-alpha@vger.kernel.org, dmaengine@vger.kernel.org,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org, jiangqi903@gmail.com,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/05/2018 10:30 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 19717e78a04d51512cf0e7b9b09c61f06b2af071 ("[PATCH V2] mm: Replace all open encodings for NUMA_NO_NODE")
> url: https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-Replace-all-open-encodings-for-NUMA_NO_NODE/20181126-203831
> 
> 
> in testcase: perf-sanity-tests
> with following parameters:
> 
> 	perf_compiler: gcc
> 	ucode: 0x7000013
> 
> 
> 
> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

The fix (in Andrew's staging tree) from Stephen Rothwell which adds <linux/numa.h>
definitions to <tools/include/linux/numa.h> should fix this.
