Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPGF3l59zDr44
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:20:05 +1000 (AEST)
In-Reply-To: <dd602a320d7a1a627774be65fa58315fa1922a0b.1502191399.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [01/12] powerpc/8xx: Simplify CONFIG_8xx checks in Makefile
Message-Id: <3xTPGD51Xyz9t44@ozlabs.org>
Date: Fri, 11 Aug 2017 22:20:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-08 at 11:58:40 UTC, Christophe Leroy wrote:
> The entire 8xx directory is omitted if CONFIG_8xx is not enabled, so
> within the 8xx/Makefile CONFIG_8xx is always y. So convert
> obj-$(CONFIG_8xx) to the more obvious obj-y.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e23e7b32bfdaaa8892d8383114f84

cheers
