Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlz74QcPzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:27 +1100 (AEDT)
In-Reply-To: <20171104212727.3228606-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>, Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: eeh: stop using do_gettimeofday()
Message-Id: <3yWlz43Ty8z9t2h@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-11-04 at 21:26:52 UTC, Arnd Bergmann wrote:
> This interface is inefficient and deprecated because of the y2038
> overflow.
> 
> ktime_get_seconds() is an appropriate replacement here, since it
> has sufficient granularity but is more efficient and uses monotonic
> time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/edfd17ff39bce59886e8249e645d6e

cheers
