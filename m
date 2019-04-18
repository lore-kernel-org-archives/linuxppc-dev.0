Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47296C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 14:08:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF952083D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 14:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF952083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lLY11p7ZzDqP0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 00:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rjwysocki.net
 (client-ip=79.96.170.134; helo=cloudserver094114.home.pl;
 envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rjwysocki.net
X-Greylist: delayed 398 seconds by postgrey-1.36 at bilbo;
 Fri, 19 Apr 2019 00:03:44 AEST
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lLS04X1xzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 00:03:44 +1000 (AEST)
Received: from 79.184.254.18.ipv4.supernova.orange.pl (79.184.254.18) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 04777e2c5748a5fc; Thu, 18 Apr 2019 15:57:00 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mohan Kumar <mohankumar718@gmail.com>
Subject: Re: [PATCH] drivers: cpuidle: This patch fix the following checkpatch
 warning.
Date: Thu, 18 Apr 2019 15:57:00 +0200
Message-ID: <4392665.MNVv1Oa0lS@kreacher>
In-Reply-To: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
References: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wednesday, April 17, 2019 4:52:34 PM CEST Mohan Kumar wrote:
> Use pr_debug instead of printk
> 
> WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then
> dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 84b1ebe..7cf9835 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -401,7 +401,7 @@ static int __init powernv_processor_idle_init(void)
>  	powernv_cpuidle_driver_init();
>  	retval = cpuidle_register(&powernv_idle_driver, NULL);
>  	if (retval) {
> -		printk(KERN_DEBUG "Registration of powernv driver failed.\n");
> +		pr_debug("Registration of powernv driver failed.\n");
>  		return retval;
>  	}
>  
> @@ -413,7 +413,7 @@ static int __init powernv_processor_idle_init(void)
>  					   "cpuidle/powernv:dead", NULL,
>  					   powernv_cpuidle_cpu_dead);
>  	WARN_ON(retval < 0);
> -	printk(KERN_DEBUG "powernv_idle_driver registered\n");
> +	pr_debug("powernv_idle_driver registered\n");
>  	return 0;
>  }
>  
> 

Recently, you've sent two different patches against two different drivers with the same subject.

IMO it is fair enough to call that "confusing".

Moreover, pr_debug() is not a direct replacement for printk(KERN_DEBUG ) as the latter does
not require dynamic debug to be enabled and I'm not really sure if you are aware of that
difference.




