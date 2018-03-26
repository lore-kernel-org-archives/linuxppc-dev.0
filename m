Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408p1817GNzF1y3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 19:57:00 +1100 (AEDT)
In-Reply-To: <1521495973-3237-2-git-send-email-paulus@ozlabs.org>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc: Use feature bit for RTC presence rather than
 timebase presence
Message-Id: <408p180CQvz9s1l@ozlabs.org>
Date: Mon, 26 Mar 2018 19:56:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-19 at 21:46:11 UTC, Paul Mackerras wrote:
> All PowerPC CPUs other than the original PPC601 have a timebase
> register rather than the "real-time clock" (RTC) register that the
> PPC601 (and the original POWER and POWER2 CPUs) had.  Currently
> we have a CPU feature bit to indicate the presence of the timebase,
> but it makes more sense to use a bit to indicate the unusual
> situation rather than the common situation.  This therefore defines
> a CPU_FTR_USE_RTC bit in place of the CPU_FTR_USE_TB bit, and
> arranges for it to be set on PPC601 systems.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c0d64cf9fefd58831ce2cc81b2683b

cheers
