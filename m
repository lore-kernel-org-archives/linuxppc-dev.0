Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 127D1DDF05
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 19:19:45 +1000 (EST)
Message-ID: <48B51C12.8060408@garzik.org>
Date: Wed, 27 Aug 2008 05:19:14 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][for 2.6.27] fs_enet: Fix SCC Ethernet on CPM2, and crash
	in fs_enet_rx_napi()
References: <Pine.LNX.4.64.0808252019030.20949@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0808252019030.20949@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, hs@denx.de, davem@davemloft.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> From: Heiko Schocher <hs@denx.de>
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Updated to apply cleanly to top of linus's tree.
> 
> - k
> 
>  arch/powerpc/include/asm/cpm2.h    |    5 +++++
>  drivers/net/fs_enet/fs_enet-main.c |    8 ++++++++
>  drivers/net/fs_enet/mac-scc.c      |    8 +++++++-
>  3 files changed, 20 insertions(+), 1 deletions(-)

applied
