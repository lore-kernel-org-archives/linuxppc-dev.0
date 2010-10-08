Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F38C7B70ED
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 10:35:36 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.1010081102090.19518@localhost.localdomain>
References: <Pine.LNX.4.64.1010081102090.19518@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 09 Oct 2010 10:31:52 +1100
Message-ID: <1286580712.2463.419.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-08 at 11:04 -0500, Kumar Gala wrote:
> Ben,
> 
> This isn't critical, but it does fix having the ppc64e_defconfig
> build cleanly.

BTW. Do you have a -next for me ? It's past time :-)

Cheers,
Ben.

> - k
> 
> The following changes since commit 6b0cd00bc396daf5c2dcf17a8d82055335341f46:
> 
>   Merge branch 'hwpoison-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-mce-2.6 (2010-10-07 13:59:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge
> 
> Kumar Gala (1):
>       powerpc/ppc64e: Fix link problem when building ppc64e_defconfig
> 
>  arch/powerpc/platforms/85xx/smp.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
