Return-Path: <kumar.gala@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 7A73A2BF2E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Nov 2004 01:27:41 +1100 (EST)
In-Reply-To: <Pine.GSO.4.61.0411091012550.25943@waterleaf.sonytel.be>
References: <Pine.GSO.4.61.0411091012550.25943@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <781C4866-325B-11D9-AD97-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Nov 2004 08:27:22 -0600
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@somerset.sps.mot.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32] Add performance counters to cpu_spec
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 9, 2004, at 3:13 AM, Geert Uytterhoeven wrote:

> On Mon, 8 Nov 2004, Kumar Gala wrote:
>  > Adds the number of performance monitor counters each PowerPC=20
> processor has to
>  > the cpu table.=A0 Makes oprofile support a bit cleaner since we =
dont=20
> need a case
>  > statement on processor version to determine the number of counters.
>  >
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> >
> > --
>  >
> > diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
> > --- a/arch/ppc/kernel/cputable.c=A0=A0=A0=A0=A0 2004-11-08 21:02:51 =
-06:00
>  > +++ b/arch/ppc/kernel/cputable.c=A0=A0=A0=A0=A0 2004-11-08 21:02:51 =
-06:00
>  > @@ -82,6 +82,7 @@
>  >=A0 =A0=A0=A0=A0 CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
> >=A0 =A0=A0=A0=A0 COMMON_PPC | PPC_FEATURE_601_INSTR | =
PPC_FEATURE_UNIFIED_CACHE,
> >=A0 =A0=A0=A0=A0 32, 32,
>  > +=A0=A0=A0=A0 0,
>  >=A0 =A0=A0=A0=A0 __setup_cpu_601
> >=A0=A0=A0=A0=A0 },
>  >=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0 /* 603 */
>
> Perhaps you want to switch to C99-style struct initialization as well?

I can change it C99-style as well as fixing the formatting, just wanted=20=

to see if there we any other comments.  Will resend with those changes=20=

if I dont hear any other feedback.

- kumar
