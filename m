Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419DsJ1H1RzF0jD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 03:06:59 +1000 (AEST)
Message-ID: <1529427882.32445.9.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: York Sun <york.sun@nxp.com>, "jocke@infinera.com"
 <joakim.tjernlund@infinera.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,  Qiang Zhao <qiang.zhao@nxp.com>
Date: Tue, 19 Jun 2018 12:04:42 -0500
In-Reply-To: <VI1PR04MB207831899BEC8092D346712B9A700@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <20180619162216.20030-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB207831899BEC8092D346712B9A700@VI1PR04MB2078.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] QE GPIO: Add qe_gpio_set_multiple
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-06-19 at 16:38 +0000, York Sun wrote:
> On 06/19/2018 09:22 AM, Joakim Tjernlund wrote:
> > This cousin to gpio-mpc8xxx was lacking a multiple pins method,
> > add one.
> > 
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > ---
> >  drivers/soc/fsl/qe/gpio.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> 
> Joakim,
> 
> I am not the maintainer for this driver. Adding Scott.
> 
> York
> 

Qiang Zhao is the maintainer for drivers/soc/fsl/qe

-Scott
