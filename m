Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0BA71A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:45 +1100 (AEDT)
In-Reply-To: <1452277810-98195-2-git-send-email-computersforpeace@gmail.com>
To: Brian Norris <computersforpeace@gmail.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
 Joe Perches <joe@perches.com>, Brian Norris <computersforpeace@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,2/2] cxl: use -Werror only with CONFIG_PPC_WERROR
Message-Id: <20160112123245.7152514076E@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-01 at 18:30:10 UTC, Brian Norris wrote:
> Some developers really like to have -Werror enabled for their code, as
> it helps to ensure warning free code. Others don't want -Werror, as it
> (for example) can cause problems when newer (or older) compilers have
> different sets of warnings, or new warnings can appear just when turning
> up the warning level (e.g., make W=1 or W=2). Thus, it seems prudent to
> have the use of -Werror be configurable.
> 
> It so happens that cxl is only built on PowerPC, and PowerPC already
> has a nice set of Kconfig options for this, under CONFIG_PPC_WERROR. So
> let's use that, and the world is a happy place again! (Note that
> PPC_WERROR defaults to =y, so the common case compile should still be
> enforcing -Werror.)
> 
> Fixes: d3d73f4b38a8 ("cxl: Compile with -Werror")
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/57f7c3932516b9f7908d9b0a24

cheers
