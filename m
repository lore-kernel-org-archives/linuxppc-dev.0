Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 4140CDDEDD
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 01:11:21 +1100 (EST)
Message-ID: <47346A7B.4030701@semihalf.com>
Date: Fri, 09 Nov 2007 15:11:07 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>	<20071106200520.10913.47002.stgit@hekate.izotz.org>
	<20071107133426.63593b98.sfr@canb.auug.org.au>
In-Reply-To: <20071107133426.63593b98.sfr@canb.auug.org.au>
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
> 
> On Tue, 06 Nov 2007 21:05:20 +0100 Marian Balakowicz <m8@semihalf.com> wrote:
>> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
>> +
>> +#include <linux/pci.h>
>> +#include <linux/of.h>
>> +#include <asm/time.h>
>> +#include <asm/io.h>
> 
> Its not clear to me that you need any of the above four includes.

#include <asm/time.h> is needed for generic_calibrate_decr() but other
few includes are in fact not necessary. Thanks.

Cheers,
m.
