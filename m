Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 622101A0313
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Mar 2016 09:29:29 +1100 (AEDT)
In-Reply-To: <20160304065732.GA17267@home.buserror.net>
To: Scott Wood <oss@buserror.net>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Pull request: scottwood/linux.git fixes
Message-Id: <20160305222929.50E8E1402D9@ozlabs.org>
Date: Sun,  6 Mar 2016 09:29:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-03 at 06:57:32 UTC, Scott Wood wrote:
> This patch fixes a regression that causes any usage of hugetlb
> on e5500 to oops.
>
> The following changes since commit fb822e6076d972691c5dd33431c10f82dda94ae9:
>
>   powerpc/hw_breakpoint: Fix oops when destroying hw_breakpoint event (2016-03-03 22:06:08 +1100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git fixes
>
> for you to fetch changes up to 37c5e942bb2eedd98c1cd1fa1f94d79f6b830c38:
>
>   powerpc/fsl-book3e: Avoid lbarx on e5500 (2016-03-03 23:43:05 -0600)
>
> ----------------------------------------------------------------
> Scott Wood (1):
>       powerpc/fsl-book3e: Avoid lbarx on e5500
>
>  arch/powerpc/mm/hugetlbpage-book3e.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/37c5e942bb2eedd98c1cd1fa1f

cheers
