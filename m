Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86F71DDE4A
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 05:32:50 +1100 (EST)
Message-ID: <47A8ABC1.9080008@pobox.com>
Date: Tue, 05 Feb 2008 13:32:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] iSeries: fix section mismatch in iseries_veth
References: <20080205141940.c6ddb479.sfr@canb.auug.org.au>
In-Reply-To: <20080205141940.c6ddb479.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> WARNING: vmlinux.o(.text+0x25dca0): Section mismatch in reference from the function .veth_probe() to the function .init.text:.veth_probe_one()
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/iseries_veth.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Jeff, can this go in through the powerpc tree?
> 
> diff --git a/drivers/net/iseries_veth.c b/drivers/net/iseries_veth.c
> index 419861c..58d3bb6 100644
> --- a/drivers/net/iseries_veth.c
> +++ b/drivers/net/iseries_veth.c
> @@ -1020,7 +1020,7 @@ static const struct ethtool_ops ops = {
>  	.get_link = veth_get_link,
>  };
>  
> -static struct net_device * __init veth_probe_one(int vlan,
> +static struct net_device *veth_probe_one(int vlan,
>  		struct vio_dev *vio_dev)
>  {


it's trivial enough to not matter, and faster to just...  applied
(if you'll pardon the bad grammar)
