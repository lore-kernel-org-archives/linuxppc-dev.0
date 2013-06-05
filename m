Return-Path: <B44306@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAC872C00A4
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 02:57:35 +1000 (EST)
Received: from mail183-db8 (localhost [127.0.0.1])	by
 mail183-db8-R.bigfish.com (Postfix) with ESMTP id 4B8856800C0	for
 <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 16:57:32 +0000 (UTC)
Received: from DB8EHSMHS016.bigfish.com (unknown [10.174.8.241])	by
 mail183-db8.bigfish.com (Postfix) with ESMTP id CA3BA140048	for
 <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 16:57:30 +0000 (UTC)
From: Pan Lijun-B44306 <B44306@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/perf: add 2 additional performance monitor
 counters for e6500 core
Date: Wed, 5 Jun 2013 16:57:02 +0000
Message-ID: <6D6F40098762114BA5B59621B6C64F20CD4D9B@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1369865562-29525-1-git-send-email-Lijun.Pan@freescale.com>
 <1369865562-29525-2-git-send-email-Lijun.Pan@freescale.com>
 <1370369443.748.8@snotra>
In-Reply-To: <1370369443.748.8@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, June 04, 2013 1:11 PM
> To: Pan Lijun-B44306
> Cc: linuxppc-dev@ozlabs.org; Pan Lijun-B44306
> Subject: Re: [PATCH 2/3] powerpc/perf: add 2 additional performance
> monitor counters for e6500 core
>=20
> On 05/29/2013 05:12:41 PM, Lijun Pan wrote:
> > diff --git a/arch/powerpc/kernel/cputable.c
> > b/arch/powerpc/kernel/cputable.c
> > index cc39139..2d4eee2 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -2073,7 +2073,7 @@ static struct cpu_spec __initdata cpu_specs[] =3D
> > {
> >  			MMU_FTR_USE_TLBILX,
> >  		.icache_bsize		=3D 64,
> >  		.dcache_bsize		=3D 64,
> > -		.num_pmcs		=3D 4,
> > +		.num_pmcs		=3D 6,
> >  		.oprofile_cpu_type	=3D "ppc/e6500",
> >  		.oprofile_type		=3D PPC_OPROFILE_FSL_EMB,
> >  		.cpu_setup		=3D __setup_cpu_e6500,
>=20
> This will overflow MAX_HWEVENTS.  Please include "powerpc perf:
> increase the perf HW events to 6" from our SDK tree before this patch
> (be sure to change "powerpc perf" to "powerpc/perf" and remove the
> gerrit tags when you do so).
>=20
> -Scott

I have done that.
-Lijun
