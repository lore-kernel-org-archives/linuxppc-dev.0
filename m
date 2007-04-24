Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75D58DDF0E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 10:27:30 +1000 (EST)
Subject: Re: [PATCH] [2/5] pasemi: enable one more hid bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070416062745.GD20196@lixom.net>
References: <20070416062634.GB20196@lixom.net>
	<20070416062745.GD20196@lixom.net>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 10:27:20 +1000
Message-Id: <1177374440.14873.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-16 at 01:27 -0500, Olof Johansson wrote:
> Minor HID change. Firmware can't know that we want this set so we have
> to set it in the kernel.

Care to document/name these bits ?
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Index: linux-2.6/arch/powerpc/kernel/cpu_setup_pa6t.S
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_pa6t.S
> +++ linux-2.6/arch/powerpc/kernel/cpu_setup_pa6t.S
> @@ -34,7 +34,7 @@ _GLOBAL(__setup_cpu_pa6t)
>  	beqlr
>  
>  	mfspr	r0,SPRN_HID5
> -	ori	r0,r0,0x30
> +	ori	r0,r0,0x38
>  	mtspr	SPRN_HID5,r0
>  
>  	mfspr	r0,SPRN_LPCR
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
