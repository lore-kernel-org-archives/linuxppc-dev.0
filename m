Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D4B8DE4F3
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:16:48 +1000 (EST)
Message-Id: <C84C9F3A-F727-4E57-AF11-68EED7EA9C3B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090502021653.GD18281@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 4/6] powerpc/85xx: Add eSDHC support for MPC8569E-MDS
	boards
Date: Fri, 8 May 2009 09:14:40 -0500
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
	<20090502021653.GD18281@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 9:16 PM, Anton Vorontsov wrote:

> Note that eSDHC and DUART0 are mutually exclusive on MPC8569E-MDS
> boards. Default option is DUART0, so eSDHC is disabled by default.
> U-Boot will fixup device tree if eSDHC should be used instead of
> DUART0.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |   10 ++++++++++
> 1 files changed, 10 insertions(+), 0 deletions(-)

tweaked the .dts to use fsl,esdhc


applied to next

- k
