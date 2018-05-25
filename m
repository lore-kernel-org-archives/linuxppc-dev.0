Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqG5LrkzF1kw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:30 +1000 (AEST)
In-Reply-To: <20180404201355.27925-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,
 11/19] powerpc/powermac: Move pmac_pfunc_base_install prototype to
 header file
Message-Id: <40skqG33pXz9s2R@ozlabs.org>
Date: Fri, 25 May 2018 21:41:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-04 at 20:13:55 UTC, Mathieu Malaterre wrote:
> The pmac_pfunc_base_install prototype was declared in powermac/smp.c since
> function was used there, move it to pmac_pfunc.h header to be visible in
> pfunc_base.c. Fix a warning treated as error with W=1:
> 
>   arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previous prototype for ‘pmac_pfunc_base_install’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f91d5998996819eaf194ff48e00d49

cheers
