Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57BCDDDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:53:40 +1100 (EST)
Date: Mon, 19 Nov 2007 23:52:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] powerpc: mpc832x mds: Fix board PHY reset code
In-Reply-To: <20071119190443.7c04ae6b.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0711192351550.1217@blarg.am.freescale.net>
References: <20071119190443.7c04ae6b.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	peter.vanackeren@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 Nov 2007, Kim Phillips wrote:

> currently the board-level PHY reset code for the mpc832x MDS messes with
> reset configuration words source settings which is plain wrong (it
> looks like this board code was cut-n-pasted from the mpc8360 mds code,
> which has the PHY reset bits in a different BCSR); this patch points
> the PHY reset code to the proper mpc832x mds PHY reset bits in the BCSR.
>
> Signed-off-by: Peter Van Ackeren <peter.vanackeren@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/platforms/83xx/mpc832x_mds.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>

applied.

- k
