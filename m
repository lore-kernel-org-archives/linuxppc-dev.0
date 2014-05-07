Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8D4C71401A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 09:20:28 +1000 (EST)
Message-ID: <1399504804.15726.354.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/1] booke/watchdog: refine and clean up the codes
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Date: Wed, 7 May 2014 18:20:04 -0500
In-Reply-To: <1399433437-19520-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1399433437-19520-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-07 at 11:30 +0800, Tang Yuantian wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Basically, this patch does the following:
> 1. Move the codes of parsing boot parameters from setup-common.c
>    to driver. In this way, code reader can know directly that
>    there are boot parameters that can change the timeout.
> 2. Make boot parameter 'booke_wdt_period' effective.
>    currently, when driver is loaded, default timeout is always
>    being used in stead of booke_wdt_period.
> 3. Wrap up the watchdog timeout in device struct and clean up
>    unnecessary codes.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@freescale.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 27 --------------------
>  drivers/watchdog/booke_wdt.c       | 51 ++++++++++++++++++++++++--------------
>  2 files changed, 33 insertions(+), 45 deletions(-)

Acked-by: Scott Wood <scottwood@freescale.com>

...but it looks like you didn't send this to the WDT maintainer and
list.

-Scott
