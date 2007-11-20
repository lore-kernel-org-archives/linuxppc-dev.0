Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11BD3DE0B3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:37:14 +1100 (EST)
Date: Tue, 20 Nov 2007 15:35:52 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] [POWERPC] mpc832x_rdb: remove spidev stub, use mmc_spi
In-Reply-To: <20071113170011.GA23979@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0711201535310.17614@blarg.am.freescale.net>
References: <20071113165825.GA23739@localhost.localdomain>
	<20071113170011.GA23979@localhost.localdomain>
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

On Tue, 13 Nov 2007, Anton Vorontsov wrote:

> mmc_spi has hit the mainline, so we can start using it.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
>

applied.

- k
