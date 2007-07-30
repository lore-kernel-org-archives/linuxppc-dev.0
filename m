Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9A27DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 05:48:31 +1000 (EST)
Message-ID: <46AE4089.5060602@garzik.org>
Date: Mon, 30 Jul 2007 15:48:25 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] gfar: Fix modpost warning
References: <Pine.LNX.4.64.0707260051550.30449@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0707260051550.30449@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Fix the following modpost warning:
> 
> WARNING: vmlinux.o(.init.text+0x1aa6c): Section mismatch: reference to .exit.text:gfar_mdio_exit (between 'gfar_init' and 'gfar_mdio_init')
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  drivers/net/gianfar_mii.c |    2 +-
>  drivers/net/gianfar_mii.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

applied
