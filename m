Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkKx31gbMzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 08:34:47 +1000 (AEST)
In-Reply-To: <1496904701-29372-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/book3s64: Move PPC_DT_CPU_FTRs and enable it by default
Message-Id: <3wkKx30sqFz9s89@ozlabs.org>
Date: Fri,  9 Jun 2017 08:34:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-08 at 06:51:41 UTC, Michael Ellerman wrote:
> The PPC_DT_CPU_FTRs is a bit misplaced in menuconfig, it shows up with
> other general kernel options. It's really more at home in the "Platform
> Support" section, so move it there.
> 
> Also enable it by default, for Book3s 64. It does mostly nothing unless
> the device tree properties are found, and we will want it enabled
> eventually in distro kernels, so turn it on to start getting more
> testing.
> 
> Fixes: 5a61ef74f269 ("powerpc/64s: Support new device tree binding for discovering CPU features")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/c6ee9619e2edd9912316f7e2eaf9ff

cheers
