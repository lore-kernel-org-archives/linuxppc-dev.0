Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 616101A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 17:04:48 +1000 (EST)
Message-ID: <1409295887.9191.6.camel@concordia>
Subject: Re: [PATCH] drivers: char: hw_random: printk replacement
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 29 Aug 2014 17:04:47 +1000
In-Reply-To: <1409238178-16496-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1409238178-16496-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 linux-geode@lists.infradead.org, Matt Mackall <mpm@selenic.com>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-28 at 20:32 +0530, Sudip Mukherjee wrote:
> as pr_* macros are more preffered over printk, so printk replaced with corresponding pr_* macros
 
I suppose ...

>  drivers/char/hw_random/pasemi-rng.c  |  2 +-
>  drivers/char/hw_random/pseries-rng.c |  2 +-

These look OK to me.

cheers
