Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id B267BDDED7
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 22:07:03 +1100 (EST)
Message-ID: <473C2846.2010701@semihalf.com>
Date: Thu, 15 Nov 2007 12:06:46 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v5 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
References: <20071114102115.31052.67271.stgit@hekate.izotz.org>
	<20071115102149.898061fb.sfr@canb.auug.org.au>
In-Reply-To: <20071115102149.898061fb.sfr@canb.auug.org.au>
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
> On Wed, 14 Nov 2007 11:21:37 +0100 Marian Balakowicz <m8@semihalf.com> wrote:
>> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
>> +#include <asm/time.h>
>> +#include <asm/machdep.h>
>> +#include <asm/mpc52xx.h>
> 
> You still need asm/prom.h because you use of_get_flat_dt_root() and
> of_flat_dt_is_compatible().
> 
>> +/* list of the supported boards */
>> +static const char *board[] __initdata = {
> 
> Unfortunately you can't use "const" and "__initdata", so just remove the
> "const".  (const changes the attributes on the section that __initdata is
> stored in.)

Arghh, too much of a hurry it seems, thanks for catching it.

Cheers,
m.
