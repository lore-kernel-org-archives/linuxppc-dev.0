Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 09659DDF9E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 01:55:53 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so827903yxb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 08 May 2009 08:55:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241791201-23960-1-git-send-email-w.sang@pengutronix.de>
References: <1241791201-23960-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 8 May 2009 09:55:31 -0600
Message-ID: <fa686aa40905080855g1b24b9f4s7a78ccb75b5be8b1@mail.gmail.com>
Subject: Re: [PATCH] net/fs_enet/mii-fec: Use PHY_POLL instead of hard coded
	'-1'
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 8, 2009 at 8:00 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Initialize the irq-table with PHY_POLL. '-1' means the same now, but is
> hardly maintainable.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Vitaly Bordug <vbordug@ru.mvista.com>
> Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: netdev@vger.kernel.org
> Cc: linuxppc-dev@ozlabs.org
> ---
> =A0drivers/net/fs_enet/mii-fec.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.=
c
> index 28077cc..9eb5480 100644
> --- a/drivers/net/fs_enet/mii-fec.c
> +++ b/drivers/net/fs_enet/mii-fec.c
> @@ -166,7 +166,7 @@ static int __devinit fs_enet_mdio_probe(struct of_dev=
ice *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_unmap_regs;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < PHY_MAX_ADDR; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->irq[i] =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->irq[i] =3D PHY_POLL;

This code no longer exists in net-next.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
