Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGR1xtqzDqpn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:59 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-13-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [12/21] powerpc: Add missing prototype for time_init
Message-Id: <401RGM4WR3z9sVk@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:27 UTC, Mathieu Malaterre wrote:
> The function time_init did not have a prototype defined in the time.h
> header. Fix the following warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/time.o
> arch/powerpc/kernel/time.c:1068:13: error: no previous prototype for ‘time_init’ [-Werror=missing-prototypes]
>  void __init time_init(void)
>              ^~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/848092faa0c7687a99bf465808f7da

cheers
