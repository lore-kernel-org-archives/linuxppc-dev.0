Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41427DE414
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 01:51:22 +1000 (EST)
Message-Id: <0536722F-08DA-4E93-BCF7-2B3E32316C2E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1210891570-9074-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Add CS4270 i2c data to fsl_soc.c
Date: Fri, 30 May 2008 10:51:10 -0500
References: <1210891570-9074-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 15, 2008, at 5:46 PM, Timur Tabi wrote:

> The i2c_devices[] array in fsl_soc.c lists all the I2C nodes that  
> are supported
> on Freescale boards.  Add an entry for the Cirrus Logic CS4270 so  
> that a
> new-style CS4270 driver will work.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied.

- k
