Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 691761A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:14:06 +1100 (AEDT)
In-Reply-To: <1450341660-31305-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc: add va_end()
Message-Id: <20160111091405.D56BE14099F@ozlabs.org>
Date: Mon, 11 Jan 2016 20:14:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-17-12 at 08:41:00 UTC, Daniel Axtens wrote:
> cppcheck picked up that there were a couple of missing va_end()
> calls in functions using va_start().
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1b855e167b90fcb353977c0893

cheers
