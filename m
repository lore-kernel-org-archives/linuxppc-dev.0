Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EA6EB6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 16:07:11 +1000 (EST)
Received: from mail197-ch1 (localhost.localdomain [127.0.0.1])	by
	mail197-ch1-R.bigfish.com (Postfix) with ESMTP id A06B4F983E9	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 06:07:05 +0000 (UTC)
Received: from CH1EHSMHS026.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.250])	by mail197-ch1.bigfish.com (Postfix) with ESMTP id
	D8EFAD88145	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 06:06:27 +0000 (UTC)
Subject: Re: [PATCH 2/4] powerpc/85xx: enable pcie initialization for P4080
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1311243914-4349-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Fri, 22 Jul 2011 01:06:22 -0500
Message-ID: <D08A7FEC-DF4F-4EF3-B064-13E91242EF91@freescale.com>
References: <1311243914-4349-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2011, at 5:25 AM, Shaohui Xie wrote:

> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> arch/powerpc/platforms/85xx/corenet_ds.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c =
b/arch/powerpc/platforms/85xx/corenet_ds.c
> index 2ab338c..15247b0 100644
> --- a/arch/powerpc/platforms/85xx/corenet_ds.c
> +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
> @@ -114,6 +114,9 @@ static const struct of_device_id of_device_ids[] =
__devinitconst =3D {
> 		.compatible	=3D "simple-bus"
> 	},
> 	{
> +		.compatible	=3D "fsl,p4080-pcie"
> +	},
> +	{
> 		.compatible	=3D "fsl,rapidio-delta",
> 	},
> 	{}
> --=20
> 1.6.4
>=20

What about p204x, p3041 & p5020 boards?

- k=
