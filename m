Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A571667BAC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:36:21 +1100 (EST)
In-Reply-To: <200611090352.kA93quLV003810@shell0.pdx.osdl.net>
References: <200611090352.kA93quLV003810@shell0.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46E7C133-FEE9-4DBD-A298-BEF957F9C39E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 1/3] ppc: booke reg MCSR msg misquoted
Date: Fri, 17 Nov 2006 00:36:34 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: "akpm@osdl.org Morton" <akpm@osdl.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, nkalmala@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

On Nov 8, 2006, at 9:52 PM, akpm@osdl.org wrote:

> From: nkalmala <nkalmala@gmail.com>
>
> PPC/booke reg MCSR value misquoted
>
> Signed-off-by: nkalmala <nkalmala@gmail.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: <linuxppc-dev@ozlabs.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/ppc/kernel/traps.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN arch/ppc/kernel/traps.c~ppc-booke-reg-mcsr-msg-misquoted  
> arch/ppc/kernel/traps.c
> --- a/arch/ppc/kernel/traps.c~ppc-booke-reg-mcsr-msg-misquoted
> +++ a/arch/ppc/kernel/traps.c
> @@ -316,7 +316,7 @@ void machine_check_exception(struct pt_r
>  	if (reason & MCSR_BUS_RBERR)
>  		printk("Bus - Read Data Bus Error\n");
>  	if (reason & MCSR_BUS_WBERR)
> -		printk("Bus - Read Data Bus Error\n");
> +		printk("Bus - Write Data Bus Error\n");
>  	if (reason & MCSR_BUS_IPERR)
>  		printk("Bus - Instruction Parity Error\n");
>  	if (reason & MCSR_BUS_RPERR)
> _
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
