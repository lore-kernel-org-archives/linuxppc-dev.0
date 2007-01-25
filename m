Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B9523DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 08:25:50 +1100 (EST)
Date: Thu, 25 Jan 2007 15:31:38 -0600
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] [2/4] powerpc: Add PMC type to cputable
Message-ID: <20070125213138.GA21704@lixom.net>
References: <20070125081951.GC10716@lixom.net>
	<1F2EE0A0-2A1D-4ADE-8081-C7C635C443D3@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1F2EE0A0-2A1D-4ADE-8081-C7C635C443D3@freescale.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 03:00:51PM -0600, Andy Fleming wrote:
> 
> On Jan 25, 2007, at 02:19, Olof Johansson wrote:
> 
> >@@ -207,6 +216,8 @@ static struct cpu_spec cpu_specs[] = {
> > 		.icache_bsize		= 128,
> > 		.dcache_bsize		= 128,
> > 		.num_pmcs		= 8,
> >+		.pmc_type		= PPC_PMC_IBM,
> >+		.pmc_type		= PPC_PMC_IBM,
> > 		.cpu_setup		= __setup_cpu_ppc970,
> > 		.cpu_restore		= __restore_cpu_ppc970,
> > 		.oprofile_cpu_type	= "ppc64/970",
> 
> 
> My guess is you only really wanted one of those pmc_types.  :)

Grmbl, yes. I took it out of one version of the patch, it snuck in
again. Thanks!


-Olof
