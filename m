Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CB13DDF20
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:49:59 +1100 (EST)
Message-Id: <2C7E7880-DD24-4851-9F27-CD5047B6AB60@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090205190451.GB3348@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/3] powerpc/83xx: Convert existing sdhc nodes to new
	bindings
Date: Fri, 6 Feb 2009 10:49:56 -0600
References: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
	<20090205190451.GB3348@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2009, at 1:04 PM, Anton Vorontsov wrote:

> - sdhc node renamed to sdhci ("sdhc" name is confusing since SDHC is
>  used to name Secure Digital High Capacity cards, while SDHCI is an
>  interface).
>
> - Get rid of "fsl,esdhc" compatible entry, it's replaced by the
>  "fsl,<chip>-esdhc" scheme;
>
> - Get rid of `model' property.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts |    7 ++++---
> arch/powerpc/boot/dts/mpc8378_mds.dts |    7 ++++---
> arch/powerpc/boot/dts/mpc8379_mds.dts |    7 ++++---
> 3 files changed, 12 insertions(+), 9 deletions(-)


applied to next

- k
