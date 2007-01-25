Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3DDC4DE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 08:01:05 +1100 (EST)
In-Reply-To: <20070125081951.GC10716@lixom.net>
References: <20070125081951.GC10716@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1F2EE0A0-2A1D-4ADE-8081-C7C635C443D3@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] [2/4] powerpc: Add PMC type to cputable
Date: Thu, 25 Jan 2007 15:00:51 -0600
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2007, at 02:19, Olof Johansson wrote:


> @@ -207,6 +216,8 @@ static struct cpu_spec cpu_specs[] = {
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
>  		.num_pmcs		= 8,
> +		.pmc_type		= PPC_PMC_IBM,
> +		.pmc_type		= PPC_PMC_IBM,
>  		.cpu_setup		= __setup_cpu_ppc970,
>  		.cpu_restore		= __restore_cpu_ppc970,
>  		.oprofile_cpu_type	= "ppc64/970",


My guess is you only really wanted one of those pmc_types.  :)
