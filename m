Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD9D4DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:54:12 +1100 (EST)
Date: Mon, 19 Nov 2007 23:52:37 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] powerpc: fix 2nd UCC entry in mpc832x_mds.dts
In-Reply-To: <20071113172631.7b42e1e1.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0711192352170.1217@blarg.am.freescale.net>
References: <20071113172631.7b42e1e1.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Nov 2007, Kim Phillips wrote:

> correct the reg property, remove duplicate io port entry, whitespace fixes.
>
> Thanks to Peter Van Ackeren for pointing this out.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_mds.dts |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>

applied

- k
