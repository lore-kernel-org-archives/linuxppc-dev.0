Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 29295DE90F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:35:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Date: Thu, 26 Jun 2008 17:35:11 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-48-git-send-email-monstr@seznam.cz>
	<1214483429-32360-49-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-49-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806261735.12738.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> +
> +#ifndef _ASM_MICROBLAZE_NAMEI_H
> +#define _ASM_MICROBLAZE_NAMEI_H
> +
> +#ifdef __KERNEL__
> +
> +/* This dummy routine maybe changed to something useful
> + * for /usr/gnemul/ emulation stuff.
> + * Look at asm-sparc/namei.h for details.
> + */
> +#define __emul_prefix() NULL
> +
> +#endif /* __KERNEL__ */
> +
> +#endif /* _ASM_MICROBLAZE_NAMEI_H */

Could you move this to asm-generic? Note that the comment is wrong,
asm-sparc doesn't actually implement it any more, only ia64, mips and
arm have an implementation that actually does something interesting
here.

	Arnd <><
