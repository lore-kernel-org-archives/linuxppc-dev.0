Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 31B3467A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 03:52:52 +1100 (EST)
In-Reply-To: <42386274.2020504@timesys.com>
References: <42386274.2020504@timesys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f37ebc53776184342f4eb01eb23efcac@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 16 Mar 2005 10:52:52 -0600
To: "Greg Weeks" <greg.weeks@timesys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [patch] fix unitilized spinlock in cpm driver when used as
	console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This may already be resolved by this patch which is in the latest bk 
tree.

http://ozlabs.org/ppc32-patches/patch.pl?id=280

- kumar

On Mar 16, 2005, at 10:44 AM, Greg Weeks wrote:

> Fix unitilized spinlock in the cpm scc driver when used as console.
>
> Signed-off-by: Greg Weeks <greg.weeks@timesys.com>
>
>  <cpm.console.spinlock.patch><ATT247771.txt>
