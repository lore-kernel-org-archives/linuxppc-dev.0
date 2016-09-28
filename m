Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skbGL2FKRzDrXZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 21:34:50 +1000 (AEST)
In-Reply-To: <1474527274-10897-2-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [1/6] powerpc/boot: add sed script
Message-Id: <3skbGL1Z1Bz9sf9@ozlabs.org>
Date: Wed, 28 Sep 2016 21:34:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-22-09 at 06:54:29 UTC, Oliver O'Halloran wrote:
> The powerpc boot wrapper is compiled with a separate "bootcc" toolchain
> rather than the toolchain used for the rest of the kernel. The main
> problem with this is that the wrapper does not have access to the kernel
> headers (without a lot of gross hacks). To get around this the required
> headers are copied into the build directory via several sed scripts
> which rewrite problematic includes. This patch moves these fixups out of
> the makefile into a separate .sed script file to clean up makefile
> slightly.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1a13de6df9bf998a0b6d9bfa42

cheers
