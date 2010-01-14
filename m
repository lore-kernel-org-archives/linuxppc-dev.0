Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FEA81007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 15:21:18 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o0E4LDAw000814
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2010 22:21:14 -0600
Subject: Re: [PATCH] Wire up recvmmsg syscall
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <1263442293.724.324.camel@pasglop>
References: <1263442293.724.324.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jan 2010 15:21:12 +1100
Message-ID: <1263442872.724.326.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-01-14 at 15:11 +1100, Benjamin Herrenschmidt wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/systbl.h |    2 ++
>  arch/powerpc/include/asm/unistd.h |    3 ++-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> index 07d2d19..0e92c23 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -326,3 +326,5 @@ SYSCALL_SPU(perf_event_open)
>  COMPAT_SYS_SPU(preadv)
>  COMPAT_SYS_SPU(pwritev)
>  COMPAT_SYS(rt_tgsigqueueinfo)
> +COMPAT_SYS_SPU(recvmmsg)
> +

Ignore. We don't need it, it's part of socketcalls. In fact, i386
neither, it's a bug there.

Cheers,
Ben.
