Return-Path: <SRS0=qk5f=QD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C89C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Nov 2021 09:39:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEA861263
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Nov 2021 09:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CEA861263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Htgy768TZz2yw1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Nov 2021 20:39:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Htgxh1mMlz2xC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Nov 2021 20:39:19 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="297081778"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="297081778"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 01:38:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="494394187"
Received: from smile.fi.intel.com ([10.237.72.184])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 01:38:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1mmuuf-007NGY-M1; Tue, 16 Nov 2021 11:38:01 +0200
Date: Tue, 16 Nov 2021 11:38:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 3/3] soc: fsl: Replace kernel.h with the necessary
 inclusions
Message-ID: <YZN7+UlXtJi8/i1L@smile.fi.intel.com>
References: <20211110105952.62013-1-andriy.shevchenko@linux.intel.com>
 <20211110105952.62013-3-andriy.shevchenko@linux.intel.com>
 <YZJExzxJ4j8g6jEY@smile.fi.intel.com>
 <AS8PR04MB8946B4800AE34258F7F2BA688F989@AS8PR04MB8946.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8946B4800AE34258F7F2BA688F989@AS8PR04MB8946.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 15, 2021 at 10:24:36PM +0000, Leo Li wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Monday, November 15, 2021 5:30 AM
> > On Wed, Nov 10, 2021 at 12:59:52PM +0200, Andy Shevchenko wrote:

...

> > > v2: updated Cc list based on previous changes to MAINTAINERS
> > 
> > Any comments on this, please?
> > 
> > I really want to decrease amount of kernel.h usage in the common headers.
> > So others won't copy'n'paste bad example.
> 
> There seems to be no problem with the patch although I didn't get time to really compile with it applied.
> 
> Will pick them up later after build test.

Thank you!

Note, it has two fixes against MAINTAINERS which may be sent, I believe,
sooner than later to Linus.

-- 
With Best Regards,
Andy Shevchenko


