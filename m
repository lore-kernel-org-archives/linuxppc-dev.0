Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43600DE1CF
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 09:06:29 +1000 (EST)
Message-Id: <D5F78DD8-91EC-420F-AF48-DCF4FFF3D386@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <48445814.4030004@garzik.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] phylib: Don't allow core of phylib to build as a module
Date: Mon, 2 Jun 2008 18:06:15 -0500
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<48442239.7090906@garzik.org>
	<B2D5CE7E-3635-4C18-BD99-E0B5B0BBC70B@kernel.crashing.org>
	<48445814.4030004@garzik.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> The whole world isn't embedded ppc, we use this stuff elsewhere too.
>>>
>>> You guys need to figure out something that doesn't require phylib  
>>> be built-in on ALL platforms, but only the platforms that require  
>>> it.
>> I wasn't suggesting we build it always, just not let it be built as  
>> a module.
>
> I was saying, you are requiring everyone to bloat their kernel with  
> phylib, if they enable phylib, because of your particular platform  
> details.
>
> That is not a path we want to follow -- limiting everyone else  
> because of one case is not acceptable.

Are you saying that all the driver subsystems that require being built  
into the kernel should be changed to not require this? (I2C, SPI, DMA  
engine, etc.)

- k
