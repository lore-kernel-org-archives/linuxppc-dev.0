Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqx69t1zF0XT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:21 +1100 (AEDT)
In-Reply-To: <20171226130020.23626-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>, 
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/xive: Properly use static keyword for inline function
Message-Id: <3zPxqw3lxgz9sNc@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-26 at 13:00:17 UTC, Mathieu Malaterre wrote:
> Fix fatal warning during compilation:
> 
> In file included from arch/powerpc/xmon/xmon.c:54:0:
> ./arch/powerpc/include/asm/xive.h:157:20: error: no previous prototype for ‘xive_smp_prepare_cpu’ [-Werror=missing-prototypes]
>  extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
>                     ^
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/38833faa112c10dd6e3d888f8b53de

cheers
