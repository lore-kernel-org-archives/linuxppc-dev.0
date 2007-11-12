Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D828EDDE33
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 04:29:44 +1100 (EST)
Message-ID: <47388D7B.9070106@freescale.com>
Date: Mon, 12 Nov 2007 11:29:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] powerpc: Add EXPORT_SYMBOL for symbols required by fs_enet
	and cpm_uart
References: <47373571.3070605@scram.de>
In-Reply-To: <47373571.3070605@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> fs_enet and cpm_uart need symbols from commproc.c (for CPM1) or
> cpm2_common.c. Add EXPORT_SYMBOL for cpmp, cpm_setbrg and cpm2_immr, so
> the drivers can be compiled as modules.
> 
>  Building modules, stage 2.
>  MODPOST 5 modules
> ERROR: "cpm2_immr" [drivers/net/fs_enet/fs_enet.ko] undefined!
> ERROR: "cpmp" [drivers/net/fs_enet/fs_enet.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

Acked-by: Scott Wood <scottwood@freescale.com>
