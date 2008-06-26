Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 0931ADE2E0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:14:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: [PATCH 31/60] microblaze_v4: memory inicialization, MMU, TLB
Date: Thu, 26 Jun 2008 17:14:11 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-31-git-send-email-monstr@seznam.cz>
	<1214483429-32360-32-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-32-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806261714.12967.arnd@arndb.de>
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

> +#include <linux/autoconf.h>

You should never need to include linux/autoconf.h anywhere,
just remove this.

> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include "../../../mm/internal.h"

Why do you need to include the internal.h file here?
If you have a good reason to do it, you should probably
add the symbol you need to a global header file.

	Arnd <><
