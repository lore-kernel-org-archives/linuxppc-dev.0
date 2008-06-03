Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7BEFDDEEB
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 14:57:31 +1000 (EST)
Message-Id: <5D468267-3E3B-4A23-BFD8-FDFB4AE987A6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1212437375-30927-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH][POWERPC] Update fsl_soc to use cell-index property of I2C
	nodes
Date: Mon, 2 Jun 2008 23:57:22 -0500
References: <1212437375-30927-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 2, 2008, at 3:09 PM, Timur Tabi wrote:

> Currently, fsl_i2c_of_init() uses the order of the I2C adapter nodes  
> in the
> device tree to enumerate the I2C adapters.  Instead, let's check for  
> the
> cell-index property and use it if it exists.
>
> This is handy for device drivers that need to identify the I2C  
> adapters by
> specific numbers.  The Freescale MPC8610 ASoC V2 sound drivers are  
> an example.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

applied.

- k
