Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AC51DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 12:54:02 +1100 (EST)
Date: Wed, 23 Jan 2008 19:51:25 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Add fixed-phy support for fs_enet
In-Reply-To: <4767E677.7010200@scram.de>
Message-ID: <Pine.LNX.4.64.0801231951150.8658@blarg.am.freescale.net>
References: <4767E677.7010200@scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, netdev@vger.kernel.org,
	Scott Wood <scottwood@freescale.com>, "Garzik, Jeff" <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Dec 2007, Jochen Friedrich wrote:

> This patch adds support to use the fixed-link property
> of an ethernet node to fs_enet for the
> CONFIG_PPC_CPM_NEW_BINDING case.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> Acked-by: Jeff Garzik <jeff@garzik.org>
> Acked-by: Vitali Bordug <vitb@kernel.crashing.org>
> ---
>  drivers/net/fs_enet/fs_enet-main.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>

applied.

- k
