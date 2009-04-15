Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id B1505DE0A6
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 01:59:44 +1000 (EST)
Received: by qyk8 with SMTP id 8so5866641qyk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 08:59:42 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1239810564-8403-1-git-send-email-galak@kernel.crashing.org>
References: <1239810564-8403-1-git-send-email-galak@kernel.crashing.org>
Date: Wed, 15 Apr 2009 10:59:42 -0500
Message-ID: <ed82fe3e0904150859y3d8cea6dv9f9b88cc4939e9df@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: Add P2020DS board support
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Ted Peters <ted.peters@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 10:49 AM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:

> --- a/arch/powerpc/platforms/fsl_uli1575.c
> +++ b/arch/powerpc/platforms/fsl_uli1575.c
> @@ -57,7 +57,7 @@ static void __devinit early_uli5249(struct pci_dev *dev=
)
> =A0 =A0 =A0 =A0unsigned char temp;
>
> =A0 =A0 =A0 =A0if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &=
&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !machine_is(mpc8572_ds))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !machine_is(mpc8572_ds) && =
!machine_is(p2020_ds))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;

Are we going to need to update this function every time we add a new
board that has an ULI 1575 on it?  Can't we define some property in
the device tree to handle this?

--=20
Timur Tabi
Linux kernel developer at Freescale
