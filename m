Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BA29DDE42
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 02:34:04 +1100 (EST)
Message-Id: <1ED67FCC-132F-4E9A-BDC9-41BF557FF0D6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1198219435310-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/3] sbc8548: Add device tree source for Wind River
	SBC8548 board
Date: Fri, 21 Dec 2007 09:33:59 -0600
References: <11982194332672-git-send-email-paul.gortmaker@windriver.com>
	<11982194344016-git-send-email-paul.gortmaker@windriver.com>
	<1198219435310-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 21, 2007, at 12:43 AM, Paul Gortmaker wrote:

> This adds the device tree source for the Wind River SBC8548 board.   
> The
> biggest difference between this and the MPC8548CDS reference platform
> is the absence of the CDS's Arcadia peripherals and physical access  
> to PCI#2.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8548.dts |  242 ++++++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 242 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/ 
> dts/sbc8548.dts
> new file mode 100644
> index 0000000..e63ed20
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/sbc8548.dts
> @@ -0,0 +1,242 @@
> +/*
> + * SBC8548 Device Tree Source
> + *
> + * Copyright 2007 Wind River Systems Inc.
> + *
> + * Paul Gortmaker (see MAINTAINERS for contact information)
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +
> +/ {
> +	model = "SBC8548";
> +	compatible = "SBC8548";
> +	#address-cells = <1>;
> +	#size-cells = <1>;

mind looking at converting this to a dts-v1 format?

- k
