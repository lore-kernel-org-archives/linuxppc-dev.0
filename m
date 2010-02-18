Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7D49B7CB9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 14:24:53 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.1002172120310.13512@localhost.localdomain>
References: <Pine.LNX.4.64.1002172120310.13512@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Feb 2010 14:24:44 +1100
Message-ID: <1266463484.16346.382.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-02-17 at 21:21 -0600, Kumar Gala wrote:
> Ben,
> 
> These are two minor fixes that should go into 2.6.33.

It's a bit late for such fixes, but it's your platforms and your call
here so I'll pull and push out to Linus.

Cheers,
Ben.

> - k
> 
> The following changes since commit 724e6d3fe8003c3f60bf404bf22e4e331327c596:
>   Linus Torvalds (1):
>         Linux 2.6.33-rc8
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge
> 
> Anton Vorontsov (1):
>       powerpc/85xx: Fix oops during MSI driver probe on MPC85xxMDS boards
> 
> Peter Tyser (1):
>       powerpc/85xx: Fix SMP when "cpu-release-addr" is in lowmem
> 
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c |    3 ++-
>  arch/powerpc/platforms/85xx/smp.c         |   21 +++++++++++++++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)
