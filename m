Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C94FC4332F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Dec 2023 13:48:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SrYZr0CXGz3dLb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Dec 2023 00:48:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=gmail.com (client-ip=192.55.52.88; helo=mgamail.intel.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SrYZF5wsqz30MD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2023 00:47:33 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426251477"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="426251477"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105719674"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1105719674"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:47:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rDm3d-00000005r64-20mK;
	Thu, 14 Dec 2023 15:47:21 +0200
Date: Thu, 14 Dec 2023 15:47:21 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v3 04/11] leds: aw2013: use devm API to cleanup module's
 resources
Message-ID: <ZXsHaXOHs5qlKt9g@smile.fi.intel.com>
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-5-gnstark@salutedevices.com>
 <c709e0f33da06db40127f3a0adcbebbd@trvn.ru>
 <fa048fec-86f2-42b5-ad36-7776c569a349@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa048fec-86f2-42b5-ad36-7776c569a349@salutedevices.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, vadimp@nvidia.com, mazziesaccount@gmail.com, peterz@infradead.org, boqun.feng@gmail.com, lee@kernel.org, kernel@salutedevices.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, hdegoede@redhat.com, mingo@redhat.com, pavel@ucw.cz, Nikita Travkin <nikita@trvn.ru>, longman@redhat.com, nikitos.tr@gmail.com, will@kernel.org, linux-leds@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 14, 2023 at 03:58:56PM +0300, George Stark wrote:
> On 12/14/23 08:42, Nikita Travkin wrote:
> > George Stark писал(а) 14.12.2023 03:30:

...

> > Btw, seems like (5..11)/11 never arrived to the lists...
> 
> Yeah there was a delay, but now all patches from series #3 are online.

Nikita is right. This patch was the last in the mailing lists. Fix your mail
gateways, it quite likely the mail server in your organisation filters out
some mails as spam or so. I highly recommend to escalate this with your IT
department.

-- 
With Best Regards,
Andy Shevchenko


