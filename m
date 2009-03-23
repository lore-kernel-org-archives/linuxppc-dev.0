Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 37E3DDDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 05:49:41 +1100 (EST)
Date: Mon, 23 Mar 2009 11:49:28 -0700 (PDT)
Message-Id: <20090323.114928.01832203.davem@davemloft.net>
To: Joakim.Tjernlund@transmode.se
Subject: Re: [PATCH] ucc_geth: Convert to net_device_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF2EE08546.DF677136-ONC1257582.0037C87E-C1257582.00388BCE@transmode.se>
References: <OF2EE08546.DF677136-ONC1257582.0037C87E-C1257582.00388BCE@transmode.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Mon, 23 Mar 2009 11:17:39 +0100

> Sorry for the WS damaged patch, but my current company mailer cannot
> handle inline patches. Due to this we are setting up a new mail system
> but it will be a few days before this is ready.
> Therefore I am attaching this patch as well, use that one
> to apply instaed of the inline variant.

This patch has other problems, anyways.

> +#if 0
> +/* not yet */
> +       .ndo_set_mac_address    = ucc_geth_set_mac_address,
> +       .ndo_change_mtu         = ucc_geth_change_mtu,
> +       .ndo_do_ioctl           = ucc_geth_do_ioctl,
> +#endif

Don't do stuff like this, please.  Even the code you are
copying from doesn't have the set_mac_address method
assignment proceted by #if 0 stuff.

Just get rid of all the unused stuff completely.
