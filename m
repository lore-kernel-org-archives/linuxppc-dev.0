Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8ED691A0BD4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 19:57:56 +1100 (AEDT)
Message-ID: <1457081875.28438.1.camel@ellerman.id.au>
Subject: Re: Pull request: scottwood/linux.git fixes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Date: Fri, 04 Mar 2016 19:57:55 +1100
In-Reply-To: <20160304065732.GA17267@home.buserror.net>
References: <20160304065732.GA17267@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-03-04 at 00:57 -0600, Scott Wood wrote:

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


I didn't see much point in forcing a merge commit, so I just let it
fast-forward.

It's running through my tests and I'll send a pull request to Linus over the
weekend.

cheers
