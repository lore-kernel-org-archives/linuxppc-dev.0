Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB553DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 01:47:15 +1100 (EST)
Message-Id: <00F15E59-07B4-436E-9CEA-B445826E5534@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20081016191200.GB13629@pengutronix.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] [RESEND] i2c-cpm: Suppress autoprobing for devices
Date: Mon, 20 Oct 2008 09:46:07 -0500
References: <20081016111300.GC3432@pengutronix.de>
	<20081016191200.GB13629@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2008, at 2:12 PM, Wolfram Sang wrote:

> Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also  
> remove
> automatic probing for this i2c controller. Might need updates to dts  
> files
> using it.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Jochen Friedrich <jochen@scram.de>
> ---
> Resend with cc to i2c.
>
> drivers/i2c/busses/i2c-cpm.c |    1 -
> 1 file changed, 1 deletion(-)

applied

- k
