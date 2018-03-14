Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RH26nLyzDqjw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:30 +1100 (AEDT)
In-Reply-To: <20180302194918.4358-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,01/21] powerpc: Remove warning on array size when empty
Message-Id: <401RH218Zgz9sVp@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-02 at 19:49:18 UTC, Mathieu Malaterre wrote:
> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
> array feature_properties is defined as an empty array, which in turn
> triggers the following warning (treated as error on W=1):
> 
>   CC      arch/powerpc/kernel/prom.o
> arch/powerpc/kernel/prom.c: In function ‘check_cpu_feature_properties’:
> arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
>   for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>                 ^
> cc1: all warnings being treated as errors
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4f1f40f7b2b4487f582ecafec64076

cheers
