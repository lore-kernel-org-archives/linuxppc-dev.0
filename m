Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFF97688E0
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2005 06:24:43 +1100 (EST)
Received: from [2002:d412:e8ba::1] (helo=caramon.arm.linux.org.uk)
	by parcelfarce.linux.theplanet.co.uk with esmtpsa
	(TLSv1:DES-CBC3-SHA:168) (Exim 4.43) id 1ElWoG-0007Ql-Hc
	for linuxppc-dev@ozlabs.org; Sun, 11 Dec 2005 19:24:36 +0000
Date: Sun, 11 Dec 2005 19:21:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Message-ID: <20051211192109.GA22537@flint.arm.linux.org.uk>
References: <20051211185212.GQ23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051211185212.GQ23349@stusta.de>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-sh@m17n.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	grundler@parisc-linux.org, matthew@wil.cx,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, parisc-linux@parisc-linux.org
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 11, 2005 at 07:52:12PM +0100, Adrian Bunk wrote:
> defconfig's shouldn't set CONFIG_BROKEN=y.

NACK.  This changes other configuration options in addition, for example
in collie_defconfig:

-CONFIG_MTD_OBSOLETE_CHIPS=y
-# CONFIG_MTD_AMDSTD is not set
-CONFIG_MTD_SHARP=y
-# CONFIG_MTD_JEDEC is not set

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
