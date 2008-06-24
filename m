Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AC24DE0A2
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 01:06:14 +1000 (EST)
Message-Id: <C8617885-3488-4A09-8DDC-0D7899C43029@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080611234214.GA5296@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/QE: use arch_initcall to probe QUICC Engine GPIOs
Date: Tue, 24 Jun 2008 10:05:57 -0500
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174705.GD28185@polina.dev.rtsoft.ru>
	<CC7DA92D-EE00-48E9-AAA0-51A13A3BD5D0@kernel.crashing.org>
	<20080611122919.GA2573@polina.dev.rtsoft.ru>
	<CF897329-1FD6-4F3D-B91C-2C7B4225126E@kernel.crashing.org>
	<20080611234214.GA5296@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2008, at 6:42 PM, Anton Vorontsov wrote:

> It was discussed that global arch_initcall() is preferred way to probe
> QE GPIOs, so let's use it.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---


applied to powerpc-next.

- k
