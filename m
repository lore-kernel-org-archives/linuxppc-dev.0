Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 27C4968888
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2005 06:31:20 +1100 (EST)
Date: Sun, 11 Dec 2005 20:31:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, matthew@wil.cx,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	kkojima@rr.iij4u.or.jp, dwmw2@infradead.org
Message-ID: <20051211193118.GR23349@stusta.de>
References: <20051211185212.GQ23349@stusta.de>
	<20051211192109.GA22537@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051211192109.GA22537@flint.arm.linux.org.uk>
Cc: linux-mtd@lists.infradead.xn--org-boa
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 11, 2005 at 07:21:10PM +0000, Russell King wrote:
> On Sun, Dec 11, 2005 at 07:52:12PM +0100, Adrian Bunk wrote:
> > defconfig's shouldn't set CONFIG_BROKEN=y.
> 
> NACK.  This changes other configuration options in addition, for example
> in collie_defconfig:
> 
> -CONFIG_MTD_OBSOLETE_CHIPS=y
> -# CONFIG_MTD_AMDSTD is not set
> -CONFIG_MTD_SHARP=y
> -# CONFIG_MTD_JEDEC is not set

That's not a problem introduced by my patch.

Either the depency of MTD_OBSOLETE_CHIPS on BROKEN is correct (in which 
case CONFIG_MTD_OBSOLETE_CHIPS=y wouldn't bring you anything), or the 
dependency on BROKEN is not correct and should be corrected.

David, can you comment on this issue?

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
