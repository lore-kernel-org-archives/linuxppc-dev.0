Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id D8587DDDF7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 22:58:28 +1100 (EST)
Message-ID: <473056D4.2040104@semihalf.com>
Date: Tue, 06 Nov 2007 12:58:12 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 10/12] [POWERPC] Motion-PRO: Add LED support.
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>	<20071103235311.31906.23754.stgit@hekate.izotz.org>
	<20071104152716.a38dc9f7.sfr@canb.auug.org.au>
In-Reply-To: <20071104152716.a38dc9f7.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Stephen,

Stephen Rothwell wrote:
> On Sun, 04 Nov 2007 00:53:11 +0100 Marian Balakowicz <m8@semihalf.com> wrote:
>> +++ b/drivers/leds/leds-motionpro.c
[snip]
>> +#include <asm/io.h>
>> +#include <asm/of_platform.h>
> 
> You want <linux/of_platform.h> instead of <asm/..> and probably not
> <linux/platform_device.h> above.
[snip]

Thanks for comments, I'll apply your suggestions for v3 respin of the
patches.

Cheers,
m.
