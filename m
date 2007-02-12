Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F41DDDD06
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:07:41 +1100 (EST)
In-Reply-To: <11713184101239-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9B771992-8763-4257-83B8-90F7D5A24EC0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 02/10] powerpc: Add device tree fixups for the EFIKA
Date: Mon, 12 Feb 2007 17:06:53 -0600
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 12, 2007, at 4:13 PM, Sylvain Munaut wrote:

> We make the efika device tree compliant with the defined bindings
> (at least compliant enough). This is mostly done by mangling
> the device_type and compatible properties, but also adding
> some missing bits.
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/powerpc/kernel/prom_init.c |   81 ++++++++++++++++++++++++++++ 
> +++++++++++
>  1 files changed, 81 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/ 
> prom_init.c
> index 520ef42..4fb5938 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2117,11 +2117,92 @@ #else
>  #define fixup_device_tree_pmac()
>  #endif
>
> +#ifdef CONFIG_PPC_EFIKA
>

can't this EFIKA fixup live in efika board code (platforms/52xx/efika*)

- k
