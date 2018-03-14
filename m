Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RH60KN0zDr2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:34 +1100 (AEDT)
In-Reply-To: <20180307203257.23542-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 open list <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [v2,15/21] powerpc: Make function MMU_setup static
Message-Id: <401RH41mZNz9sVv@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-07 at 20:32:55 UTC, Mathieu Malaterre wrote:
> Since function `MMU_setup` is not meant to be exported, change the
> signature to `static`. Fix warning (treated as error with W=1):
> 
>   CC      kernel/sys.o
> arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for ‘MMU_setup’ [-Werror=missing-prototypes]
>  void __init MMU_setup(void)
>              ^~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d15a261d876da3267c8c706ef21e7f

cheers
