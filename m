Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 026C567A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 03:51:19 +1100 (EST)
In-Reply-To: <42386209.2070407@timesys.com>
References: <42386209.2070407@timesys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <246b789ef278b37c931695987cb49f68@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 16 Mar 2005 10:51:21 -0600
To: "Greg Weeks" <greg.weeks@timesys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [patch] fix gianfar unitilized spinlock.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greg,

This has already been fixed in the current bk tree.

http://ozlabs.org/ppc32-patches/patch.pl?id=279

- kumar

On Mar 16, 2005, at 10:42 AM, Greg Weeks wrote:

> Fix unitilized spinlock in the gianfar tsec etherenet driver.
>
> Signed-off-by: Greg Weeks <greg.weeks@timesys.com>
> <gianfar.spinlock.patch><ATT152677.txt>
