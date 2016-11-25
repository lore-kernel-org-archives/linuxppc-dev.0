Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBb3k7MzDvk5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:07 +1100 (AEDT)
In-Reply-To: <e2b9504b6b547a9008b7a2203fb1bccebb71da89.1479742486.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2,
 1/2] powerpc: initial stack protector (-fstack-protector) support
Message-Id: <3tPxBb2Gq3z9t1B@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 10:49:30 UTC, Christophe Leroy wrote:
> Partialy copied from commit c743f38013aef ("ARM: initial stack protector
> (-fstack-protector) support")
> 
> This is the very basic stuff without the changing canary upon
> task switch yet.  Just the Kconfig option and a constant canary
> value initialized at boot time.
> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6533b7c16ee5712041b4e324100550

cheers
