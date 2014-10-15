Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87A751A02CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:08:11 +1100 (EST)
In-Reply-To: <1412919926-13123-1-git-send-email-vvijayan@mvista.com>
To: Vineeth Vijayan <vvijayan@mvista.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Fix Text randomization
Message-Id: <20141015020811.7904E14011B@ozlabs.org>
Date: Wed, 15 Oct 2014 13:08:11 +1100 (EST)
Cc: Vineeth Vijayan <vvijayan@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-10 at 05:45:26 UTC, Vineeth Vijayan wrote:
> Right now there is no way to disable TEXT randomization on a PPC32
> machine. text randomization happens even in the case of "echo 0 >
> /proc/sys/kernel/randomize_va_space"

Yeah it seems to happen on ppc64 too.

> This happens due to the incorrect definition of ELF_ET_DYN_BASE at
> arch/powerpc/include/asm/elf.h

What is incorrect about it? We are not the only arch that does that.

I'm not clear on what has changed to break this?

cheers
