Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2752968869
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2005 04:31:53 +1100 (EST)
Date: Tue, 13 Dec 2005 17:31:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Message-ID: <20051213173112.GA24094@flint.arm.linux.org.uk>
References: <20051211185212.GQ23349@stusta.de>
	<20051211192109.GA22537@flint.arm.linux.org.uk>
	<20051211193118.GR23349@stusta.de>
	<20051211194437.GB22537@flint.arm.linux.org.uk>
	<20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de>
	<20051213140001.GG23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051213140001.GG23349@stusta.de>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, grundler@parisc-linux.org,
	matthew@wil.cx, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	linux-mtd@lists.infradead.org, dwmw2@infradead.org,
	kkojima@rr.iij4u.or.jp, parisc-linux@parisc-linux.org
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 13, 2005 at 03:00:01PM +0100, Adrian Bunk wrote:
> defconfig files are virtually never a configuration for the kernel they 
> are shipped with since they aren't updated every time some configuration 
> option is changed.
> 
> Consider a defconfig with CONFIG_BROKEN=n, and a driver that is enabled 
> in this defconfig gets for some reason marked as broken in the Kconfig 
> file - this will give exactly the same result as the one you describe.

Adrian,

The defconfig files in arch/arm/configs are for platform configurations
and are provided by the platform maintainers as a _working_ configuration
for their platform.  They're not "defconfigs".  They got called
"defconfigs" as a result of the kbuild "cleanups".  Please don't confuse
them as such.

If, in order to have a working platform configuration, they deem that
CONFIG_BROKEN must be enabled, then that's the way it is.

Therefore, I request that either you leave the ARM platform configurations
well alone, or follow the advice I've given so that we can _properly_
assess the impact of your changes.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
