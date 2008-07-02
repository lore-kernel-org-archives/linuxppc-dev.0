Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71484DE625
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 03:46:55 +1000 (EST)
Message-Id: <867439D1-85C8-4E10-B103-AA7265416522@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dave Jiang <djiang@mvista.com>
In-Reply-To: <20080616223617.GA23646@blade.az.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2] 85xx: publish of device for cds platforms
Date: Wed, 2 Jul 2008 12:41:18 -0500
References: <20080616213134.GA22354@blade.az.mvista.com>
	<4856DCD1.50402@freescale.com>
	<20080616223617.GA23646@blade.az.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 16, 2008, at 5:36 PM, Dave Jiang wrote:

> Publish the devices listed in dts under SOC as of_device for 85xx_cds
> platform. The devices are needed by the 85xx EDAC driver.
>
> Signed-off-by: Dave Jiang <djiang@mvista.com>
>
> ---
>
> Added "simple bus" per Scott Wood
>
> mrch/powerpc/platforms/85xx/pc85xx_cds.c |   15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>

applied.

- k
