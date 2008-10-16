Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 853ACDDEF0
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 03:09:37 +1100 (EST)
Message-Id: <FC91562A-D6B4-4E62-A5EA-43171A80B766@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20081016111300.GC3432@pengutronix.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] i2c-cpm: Suppress autoprobing for devices
Date: Thu, 16 Oct 2008 11:09:30 -0500
References: <20081016111300.GC3432@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2008, at 6:13 AM, Wolfram Sang wrote:

>
> Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also  
> remove
> automatic probing for this i2c controller. Might need updates to dts  
> files
> using it.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> drivers/i2c/busses/i2c-cpm.c |    1 -
> 1 file changed, 1 deletion(-)

The i2c list should be CC'd.  Jean should pick this up.

- k
