Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29946DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:20:46 +1000 (EST)
Date: Thu, 10 May 2007 00:16:05 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
In-Reply-To: <1178142818.32136.51.camel@ld0161-tx32>
Message-ID: <Pine.LNX.4.64.0705100015570.27791@localhost.localdomain>
References: <1178142818.32136.51.camel@ld0161-tx32>
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

> From: Jason Jin <jason.jin@freescale.com>
>
> HD interface and AC97 interface share some pins and they are enabled at
> the same time, In order to use AC97 interface, we need to disable the HD
> interface first.
>
> Signed-off-by:Jason Jin<jason.jin@freescale.com>
> Acked-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>

applied.

- k
