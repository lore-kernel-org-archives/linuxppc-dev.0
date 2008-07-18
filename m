Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08C27DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 01:28:54 +1000 (EST)
Message-Id: <8D84340F-427C-403B-8121-481642478B8C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200806181908.41525.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
Date: Fri, 18 Jul 2008 10:28:45 -0500
References: <4808D75B.9000002@scram.de>
	<200806131715.59345.laurentp@cse-semaphore.com>
	<48593E56.70708@scram.de>
	<200806181908.41525.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 12:08 PM, Laurent Pinchart wrote:

> +#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
> +
> +struct cpm2_ioports {
> +	u32 dir, par, sor, odr, dat;
> +	u32 res[3];
> +};
> +

is this really common for both CPM2 and 8xx?  if so why the name?

- k
