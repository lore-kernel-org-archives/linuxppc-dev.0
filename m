Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 467ADDDF0E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 10:02:29 +1000 (EST)
Date: Tue, 23 Oct 2007 19:09:41 -0500
From: Olof Johansson <olof@lixom.net>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 02/11] [POWERPC] Add 'lpb' bus type for MPC5200
	LocalPlus Bus
Message-ID: <20071024000941.GA10926@lixom.net>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231315.29359.87832.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023231315.29359.87832.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, Oct 24, 2007 at 01:13:15AM +0200, Marian Balakowicz wrote:
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---

Your patch lacks any kind of description beyond the title. (I know, it's a
real simple patch, but a real simple description would do too :)

> --- a/arch/powerpc/kernel/of_platform.c
> +++ b/arch/powerpc/kernel/of_platform.c
> @@ -49,6 +49,7 @@ static struct of_device_id of_default_bus_ids[] = {
>  	{ .type = "plb4", },
>  	{ .type = "opb", },
>  	{ .type = "ebc", },
> +	{ .type = "lpb", },

I thought it was consensus to keep the new bus ids only in platform
code and not add them to the default list, and just pass that list in
to of_platform_bus_probe().




-Olof
