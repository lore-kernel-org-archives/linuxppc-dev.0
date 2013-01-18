Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B4D822C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 12:52:00 +1100 (EST)
Date: Fri, 18 Jan 2013 09:51:41 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v6 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130118015139.GA17155@nchen-desktop>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
 <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
 <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
 <20727.57269.347099.324284@ipc1.ka-ro>
 <CAOMZO5DNVMAG3btGR7DeukgWaEaPe2zqm=EKAHQ5ovawq+BiWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <CAOMZO5DNVMAG3btGR7DeukgWaEaPe2zqm=EKAHQ5ovawq+BiWw@mail.gmail.com>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2013 at 12:43:23PM -0200, Fabio Estevam wrote:
> On Thu, Jan 17, 2013 at 9:25 AM, Lothar Wa=DFmann <LW@karo-electronics.=
de> wrote:
>=20
> > The equivalent of !cpu_is_mx51() would be
> > strcmp(pdev->id_entry->name, "imx-udc-mx51") (without the '!') meanin=
g
> > id_entry->name is different from "imx-udc-mx51".

Thanks, Lothar and Fabio, I will change, and send v7.
>=20
> Yes, agree.
>=20
> strcmp(pdev->id_entry->name, "imx-udc-mx51") is also better than
> !strcmp(pdev->id_entry->name, "imx-udc-mx27"))

We just think this feature only belongs to imx-udc-mx27 type udc
>=20
> because in the case of another soc entry gets added, let's say
> "imx-udc-mxyy" then
>=20
> !strcmp(pdev->id_entry->name, "imx-udc-mx27")) will not correspond to
> !cpu_is_mx51() anymore.
>=20

--=20

Best Regards,
Peter Chen
