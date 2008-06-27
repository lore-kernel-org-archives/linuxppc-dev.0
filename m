Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16C75DDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 14:58:45 +1000 (EST)
Message-ID: <4864737D.80306@garzik.org>
Date: Fri, 27 Jun 2008 00:58:37 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 06/12] net: use linux/of_{device,platform}.h instead of asm
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523162854.2e6ea8f0.sfr@canb.auug.org.au>
In-Reply-To: <20080523162854.2e6ea8f0.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/fs_enet/fs_enet-main.c |    2 +-
>  drivers/net/fs_enet/mac-scc.c      |    2 +-
>  drivers/net/fs_enet/mii-fec.c      |    2 +-
>  drivers/net/ibm_newemac/core.h     |    2 +-
>  drivers/net/ucc_geth.c             |    2 +-
>  drivers/net/ucc_geth_mii.c         |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

ACK

I'll let a ppc person queue this
