Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C81C01A0367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 15:35:33 +1000 (EST)
Date: Mon, 11 Aug 2014 07:35:16 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] net: ugg_geth: Fix build error in -next
Message-ID: <20140811053516.GE5134@pengutronix.de>
References: <1407687554-14539-1-git-send-email-linux@roeck-us.net>
 <20140810183622.GC5134@pengutronix.de>
 <53E7BD21.6010301@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <53E7BD21.6010301@roeck-us.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Guenter,

On Sun, Aug 10, 2014 at 11:42:41AM -0700, Guenter Roeck wrote:
> On 08/10/2014 11:36 AM, Uwe Kleine-König wrote:
> >On Sun, Aug 10, 2014 at 09:19:14AM -0700, Guenter Roeck wrote:
> >>powerpc:mpc83xx_defconfig and other builds fail with
> >>
> >>drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_remove':
> >>drivers/net/ethernet/freescale/ucc_geth.c:3927:19: error:
> >>	'struct ucc_geth_private' has no member named 'info'
> >>   of_node_put(ugeth->info->tbi_node);
> >>                      ^
> >>drivers/net/ethernet/freescale/ucc_geth.c:3928:19: error:
> >>	     'struct ucc_geth_private' has no member named 'info'
> >>   of_node_put(ugeth->info->phy_node);
> >>   		     ^
> >>
> >>Introduced by commit "net: ucc_geth: drop acquired references in probe error
> >>path and remove".
> >>
> >> From the context, it appears that the variable is named ug_info.
> >>
> >>Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >>Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>---
> >>Only seen in -next.
> >My patch was only sent just now, but it has the subject right:
> >
> Excellent.
> 
> >	http://mid.gmane.org/1407695525-32227-1-git-send-email-u.kleine-koenig@pengutronix.de
> >
> The link doesn't seem to work for some reason.
It didn't work for me when I sent the mail either. I thought gmane will
have indexed the mail in a few minutes though. Gmane is broken somehow,
when I follow the Subject link of
http://article.gmane.org/gmane.linux.network/326013 I also get a No such
article page?! :-(

http://patchwork.ozlabs.org/patch/378854/ is a link that works for me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
