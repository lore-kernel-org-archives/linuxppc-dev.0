Return-Path: <pku.leo@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426RW43FZGzF3TG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 04:56:48 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so29118752oix.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 11:56:48 -0700 (PDT)
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com.
 [209.85.218.47])
 by smtp.gmail.com with ESMTPSA id r81-v6sm5650173oih.28.2018.09.07.11.56.45
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Sep 2018 11:56:45 -0700 (PDT)
Received: by mail-oi0-f47.google.com with SMTP id l202-v6so29094921oig.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 11:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-3-ran.wang_1@nxp.com>
 <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
 <CADRPPNQN=27+pOSckxvwSuBJoFaz7pT+Z6h07Wu3Liz5ao5kkA@mail.gmail.com>
 <AM5PR0402MB2865E57EDC0DE8B0047282A2F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB2865E57EDC0DE8B0047282A2F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 7 Sep 2018 13:56:33 -0500
Message-ID: <CADRPPNTGrKBxzpbP05R0T3ovngYgQ4P_kgwgYwB6Aqrs8maXqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>, dongsheng.wang@hxt-semitech.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 7, 2018 at 4:51 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Leo,
>
> On September 05, 2018 at 11:22 Yang Li wrote:
> > -----Original Message-----
> > From: Li Yang <leoyang.li@nxp.com>
> > Sent: Wednesday, September 05, 2018 11:22
> > To: dongsheng.wang@hxt-semitech.com
> > Cc: Ran Wang <ran.wang_1@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> > Mark Rutland <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND
> > FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linuxppc-
> > dev <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>;
> > moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> > kernel@lists.infradead.org>
> > Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
> >
> > On Tue, Sep 4, 2018 at 9:58 PM Wang, Dongsheng <dongsheng.wang@hxt-
> > semitech.com> wrote:
> > >
> > > Please change your comments style.
> >
> > Although this doesn't get into the Linux kernel coding style documentation
> > yet, Linus seems changed his mind to prefer // than /*
> > */ comment style now.
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml
> > .org%2Flkml%2F2017%2F11%2F25%2F133&amp;data=02%7C01%7Cran.wang_
> > 1%40nxp.com%7Cc0d88e6690384e02b95108d612dec235%7C686ea1d3bc2b4c
> > 6fa92cd99c5c301635%7C0%7C0%7C636717145285126200&amp;sdata=JIoCZp
> > WhRyW76EqgSflfTDA1f0gMQGKa%2FcbvSc5CO%2Fw%3D&amp;reserved=0
> > So the
> > // style should be acceptable for now.
> >
> > >
> > > On 2018/8/31 11:56, Ran Wang wrote:
> > > > The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> > > > Control and Power Management), which performs all device-level tasks
> > > > associated with power management such as wakeup source control.
> > > >
> > > > This driver depends on FSL platform PM driver framework which help
> > > > to isolate user and PM service provider (such as RCPM driver).
> > > >
> > > > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > > > Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > ---
> > > >  drivers/soc/fsl/Kconfig   |    6 ++
> > > >  drivers/soc/fsl/Makefile  |    1 +
> > > >  drivers/soc/fsl/ls-rcpm.c |  153
> > > > +++++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 160 insertions(+), 0 deletions(-)  create mode
> > > > 100644 drivers/soc/fsl/ls-rcpm.c
> > > >
> > > > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> > > > 6517412..882330d 100644
> > > > --- a/drivers/soc/fsl/Kconfig
> > > > +++ b/drivers/soc/fsl/Kconfig
> > > > @@ -30,3 +30,9 @@ config FSL_PLAT_PM
> > > >         have to know the implement details of wakeup function it require.
> > > >         Besides, it is also easy for service side to upgrade its logic when
> > > >         design changed and remain user side unchanged.
> > > > +
> > > > +config LS_RCPM
> > > > +     bool "Freescale RCPM support"
> > > > +     depends on (FSL_PLAT_PM)
> > > > +     help
> > > > +       This feature is to enable specified wakeup source for system sleep.
> > > > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> > > > index 8f9db23..43ff71a 100644
> > > > --- a/drivers/soc/fsl/Makefile
> > > > +++ b/drivers/soc/fsl/Makefile
> > > > @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)            += qe/
> > > >  obj-$(CONFIG_CPM)                    += qe/
> > > >  obj-$(CONFIG_FSL_GUTS)                       += guts.o
> > > >  obj-$(CONFIG_FSL_PLAT_PM)    += plat_pm.o
> > > > +obj-$(CONFIG_LS_RCPM)                += ls-rcpm.o
> >
> > Probably use "_" instead of "-" for alignment.
>
> OK, will update in next version
>
> > > > diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c
> > > > new file mode 100644 index 0000000..b0feb88
> > > > --- /dev/null
> > > > +++ b/drivers/soc/fsl/ls-rcpm.c
> > > > @@ -0,0 +1,153 @@
> > > > +// SPDX-License-Identifier: GPL-2.0 // // plat_pm.c - Freescale
> > > > +Layerscape RCPM driver
> >
> > The file name here is not the same as the real file name.
>
> Got it, will correct it.
>
> > > > +//
> > > > +// Copyright 2018 NXP
> > > > +//
> > > > +// Author: Ran Wang <ran.wang_1@nxp.com>,
> >
> > Where do you need the comma in the end?
>
> My bad, will remove comma in next version.
>
> > > > +
> > > > +#include <linux/init.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/slab.h>
> > > > +#include <soc/fsl/plat_pm.h>
> > > > +
> > > > +#define MAX_COMPATIBLE_NUM   10
> > > > +
> > > > +struct rcpm_t {
> > > > +     struct device *dev;
> > > > +     void __iomem *ippdexpcr_addr;
> > > > +     bool big_endian;        /* Big/Little endian of RCPM module */
> > > > +};
> > > > +
> > > > +// rcpm_handle - Configure RCPM reg according to wake up source
> > > > +request // @user_dev: pointer to user's device struct // @flag: to
> > > > +enable(true) or disable(false) wakeup source // @handle_priv:
> > > > +pointer to struct rcpm_t instance // // Return 0 on success other
> > > > +negative errno
> >
> > Although Linus preferred this // comment style.  I'm not sure if this will be
> > handled correctly by the kernel-doc compiler.
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
> > w.kernel.org%2Fdoc%2Fhtml%2Fv4.18%2Fdoc-guide%2Fkernel-
> > doc.html&amp;data=02%7C01%7Cran.wang_1%40nxp.com%7Cc0d88e669038
> > 4e02b95108d612dec235%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C636717145285126200&amp;sdata=H7GkUNOLVG%2FCcZESzhtHBeHCbO9
> > %2FK4k9EdH30Cxq2%2BM%3D&amp;reserved=0
>
> So, do you think I need to change all comment style back to '/* ... */' ?
> Actually I feel a little bit confused here.

I think Linus's comment about // comment style applies to normal code
comment.  But kernel-doc comment is a special kind of code comment
that needs to meet certain requirements.  People can use the
scripts/kernel-doc tool to generate readable API documents from the
source code.  It looks like you wanted to make the function
description aligned with the kernel-doc format, but kernel-doc
specifically requires to use the /* */ style(at least for now).

Regards,
Leo
