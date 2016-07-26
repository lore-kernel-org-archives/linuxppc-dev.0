Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0070.outbound.protection.outlook.com [104.47.2.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzBSk0l0VzDrK3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 18:42:12 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Jason Cooper <jason@lakedaemon.net>
CC: "oss@buserror.net" <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: RE: [Patch v3 1/3] irqchip/qeic: move qeic driver from
 drivers/soc/fsl/qe
Date: Tue, 26 Jul 2016 02:06:49 +0000
Message-ID: <AM3PR04MB11855689FACD339AE1814B3E910E0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1469437196-38003-1-git-send-email-qiang.zhao@nxp.com>
 <20160725192333.GB4541@io.lakedaemon.net>
In-Reply-To: <20160725192333.GB4541@io.lakedaemon.net>
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

Hi Jason,

On Mon, Jul 26, 2016 at 03:24AM, Jason Cooper wrote:
> -----Original Message-----
> From: Jason Cooper [mailto:jason@lakedaemon.net]
> Sent: Tuesday, July 26, 2016 3:24 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; Xiaobo Xie <xiaobo.xie@nxp.com>
> Subject: Re: [Patch v3 1/3] irqchip/qeic: move qeic driver from
> drivers/soc/fsl/qe
>=20
> >
> >  static DEFINE_RAW_SPINLOCK(qe_ic_lock);
> >
> > diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
> > index 2031d38..51e4726 100644
> > --- a/drivers/soc/fsl/qe/Makefile
> > +++ b/drivers/soc/fsl/qe/Makefile
> > @@ -1,7 +1,7 @@
> >  #
> >  # Makefile for the linux ppc-specific parts of QE  #
> > -obj-$(CONFIG_QUICC_ENGINE)+=3D qe.o qe_common.o qe_ic.o qe_io.o
> > +obj-$(CONFIG_QUICC_ENGINE)+=3D qe.o qe_common.o qe_io.o
> >  obj-$(CONFIG_CPM)	+=3D qe_common.o
> >  obj-$(CONFIG_UCC)	+=3D ucc.o
> >  obj-$(CONFIG_UCC_SLOW)	+=3D ucc_slow.o
> > diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
> > deleted file mode 100644 index 926a2ed..0000000
> > --- a/drivers/soc/fsl/qe/qe_ic.h
> > +++ /dev/null
> > @@ -1,103 +0,0 @@
> > -/*
> > - * drivers/soc/fsl/qe/qe_ic.h
> > - *
> > - * QUICC ENGINE Interrupt Controller Header
> > - *
> > - * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserve=
d.
> > - *
> > - * Author: Li Yang <leoli@freescale.com>
> > - * Based on code from Shlomi Gridish <gridish@freescale.com>
> > - *
> > - * This program is free software; you can redistribute  it and/or
> > modify it
> > - * under  the terms of  the GNU General  Public License as published
> > by the
> > - * Free Software Foundation;  either version 2 of the  License, or
> > (at your
> > - * option) any later version.
> > - */
>=20
> Please transfer this over as well, and update is as necessary.

Thank you for your review!
The author and the copyright is the same as the .c file, how to transfer th=
is?
And could you tell me what should I do for update?

Thank you!
-Zhao Qiang
