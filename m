Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACFBAB6EEC
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2012 05:18:23 +1100 (EST)
Message-ID: <4F720462.5020400@freescale.com>
Date: Tue, 27 Mar 2012 13:18:10 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
 <4F63A7A4.4000205@freescale.com> <20120319160452.B57D13E05A5@localhost>
 <4F677E51.8030905@freescale.com> <20120320170942.0C4143E2834@localhost>
 <4F68BD6F.2090008@freescale.com> <4F69F099.4070409@freescale.com>
In-Reply-To: <4F69F099.4070409@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant, do you have a moment to consider my question?  Like I said, I'm
anxious to get a fix into 3.3.

Timur Tabi wrote:
> Timur Tabi wrote:
>> They only problem I see with this is that I am thinking about modifying
>> the drivers/dma driver to probe on "fsl,eloplus-dma-channel" channels
>> directly.  If I do that, then who should call of_platform_populate()?
> 
> Grant, could you tell me if there's anything actually work with my patch?
>  All I'm doing is adding a couple more commonly used entries to
> mpc85xx_common_ids[].  After all, they're common IDs, so don't they belong
> into an array called common_ids?
> 
> I've been waiting for months for this problem to be fixed, and 3.3 is
> broken without it.  We've already established that you cannot actually
> call of_platform_bus_probe() twice on the same level, so it's not like my
> patch description is wrong or anything.
> 


-- 
Timur Tabi
Linux kernel developer at Freescale
