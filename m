Return-Path: <york.sun@nxp.com>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80075.outbound.protection.outlook.com [40.107.8.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419DD76HHdzF0wj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:38:15 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Scott Wood <oss@buserror.net>
Subject: Re: [PATCH] QE GPIO: Add qe_gpio_set_multiple
Date: Tue, 19 Jun 2018 16:38:08 +0000
Message-ID: <VI1PR04MB207831899BEC8092D346712B9A700@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <20180619162216.20030-1-joakim.tjernlund@infinera.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2018 09:22 AM, Joakim Tjernlund wrote:=0A=
> This cousin to gpio-mpc8xxx was lacking a multiple pins method,=0A=
> add one.=0A=
> =0A=
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>=0A=
> ---=0A=
>  drivers/soc/fsl/qe/gpio.c | 28 ++++++++++++++++++++++++++++=0A=
>  1 file changed, 28 insertions(+)=0A=
> =0A=
=0A=
Joakim,=0A=
=0A=
I am not the maintainer for this driver. Adding Scott.=0A=
=0A=
York=0A=
