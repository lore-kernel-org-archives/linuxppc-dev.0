Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04646DDF82
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 01:00:45 +1100 (EST)
Message-Id: <ED4FCA66-6032-4F4A-958C-8FD7DDB7CBE9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0810240059170.9657@axis700.grange>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] fix i2c on PPC linkstation / kurobox machines
Date: Tue, 28 Oct 2008 08:58:57 -0500
References: <20081022191650.GA11406@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810232029380.9657@axis700.grange>
	<20081023213309.GA19777@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810240059170.9657@axis700.grange>
Cc: Michael Weiser <michael@weiser.dinsnail.net>,
	=?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 23, 2008, at 6:05 PM, Guennadi Liakhovetski wrote:

> i2c is broken on linkstation / kurobox machines since at least  
> 2.6.27. Fix
> it. Also remove CONFIG_SERIAL_OF_PLATFORM, which, if enabled, breaks  
> the
> serial console after the "console handover: boot [udbg0] -> real  
> [ttyS1]"
> message.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> ---
>
> No, I do not really understand why I have to remove
> CONFIG_SERIAL_OF_PLATFORM now after adding a call to
> of_platform_bus_probe(), but it works this way. It must have  
> something to
> do with the legacy serial driver... If accepted in this form, I'll  
> also
> forward it to stable.
>
> diff --git


applied to merge.

- k
