Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08751DE0E2
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 23:12:29 +1100 (EST)
Date: Thu, 16 Oct 2008 13:04:16 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mfd/wm8350: don't export static functions
Message-ID: <20081016120416.GA5753@rakim.wolfsonmicro.main>
References: <20081016204754.a41646e5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081016204754.a41646e5.sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 16, 2008 at 08:47:54PM +1100, Stephen Rothwell wrote:
> Today's linux-next build (powerpc allyesconfig) failed like this:

> drivers/mfd/wm8350-core.c:1131: error: __ksymtab_wm8350_create_cache causes a section type conflict

> Caused by commit 89b4012befb1abca5e86d232bc0e2a797b0d9825 ("mfd: Core
> support for the WM8350 AudioPlus PMIC"). wm8350_create_cache is not used
> elsewhere, so remove the EXPORT_SYMBOL.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
