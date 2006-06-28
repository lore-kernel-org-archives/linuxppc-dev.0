Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3891B679F0
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 08:45:05 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc 
In-Reply-To: Your message of "Wed, 28 Jun 2006 01:01:12 CDT."
	<Pine.LNX.4.44.0606280057580.2211-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0606280057580.2211-100000@gate.crashing.org> 
Date: Wed, 28 Jun 2006 17:44:57 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FvimH-00054M-8s@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> Please pull from 'for_paulus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
> 
> to receive the following updates:
> 
>  arch/powerpc/kernel/cputable.c             |   12 --
>  arch/powerpc/platforms/86xx/mpc86xx.h      |    8 +
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  128 +++++++++++++++++++++++++-
> -
>  arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    9 -
>  arch/powerpc/platforms/86xx/pci.c          |  136 +-------------------------
> ---
>  include/asm-powerpc/mpc86xx.h              |    4 
>  6 files changed, 138 insertions(+), 159 deletions(-)
> 
> Kumar Gala:
>       powerpc: minor cleanups for mpc86xx
> 

Kumar,

Looks good to me.  I'll pull them to the 86xx tree.

Thanks!
jdl
