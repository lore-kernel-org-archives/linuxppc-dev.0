Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqF6vmyzF1kw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:29 +1000 (AEST)
In-Reply-To: <20180404201504.28003-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,09/19] powerpc/chrp/pci: Make some functions static
Message-Id: <40skqF5zQZz9s08@ozlabs.org>
Date: Fri, 25 May 2018 21:41:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-04 at 20:15:03 UTC, Mathieu Malaterre wrote:
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/platforms/chrp/pci.c:34:5: error: no previous prototype for ‘gg2_read_config’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/pci.c:61:5: error: no previous prototype for ‘gg2_write_config’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/pci.c:97:5: error: no previous prototype for ‘rtas_read_config’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/pci.c:112:5: error: no previous prototype for ‘rtas_write_config’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/910be6be6c00e6d33d47985586c392

cheers
