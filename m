Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4712BDDF20
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 02:21:57 +1000 (EST)
Date: Thu, 10 May 2007 11:17:31 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
In-Reply-To: <1178141683.32136.46.camel@ld0161-tx32>
Message-ID: <Pine.LNX.4.64.0705101117200.6072@localhost.localdomain>
References: <1178141683.32136.46.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2 May 2007, Jon Loeliger wrote:

> From: James.Yang <James.Yang@freescale.com>
>
> Remove CPU_FTR_NEED_COHERENT for MPC7448 (and single-core MPC86xx).
> This prevents needlessly setting M=1 when not SMP.
>
> Signed-off-by: James.Yang <James.Yang@freescale.com>
> Acked-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/kernel/cputable.c |    2 +-
>  include/asm-powerpc/cputable.h |    6 ++++++
>  2 files changed, 7 insertions(+), 1 deletions(-)
>

applied.

- k
