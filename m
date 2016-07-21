Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw90v5Rz5zDqTg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:26:07 +1000 (AEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Scott Wood <oss@buserror.net>, "Arnd Bergmann" <arnd@arndb.de>
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <1469039508.25630.17.camel@buserror.net>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yangbo Lu" <yangbo.lu@nxp.com>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <1468723822-30457-5-git-send-email-oss@buserror.net>
 <4016699.uYaV8nWfqC@wuerfel> <1469039508.25630.17.camel@buserror.net>
Message-ID: <146909676646.16700.8383344640490662952@concordia>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Thu, 21 Jul 2016 20:26:06 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Scott Wood (2016-07-21 04:31:48)
> On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> > On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > > =

> > > From: yangbo lu <yangbo.lu@nxp.com>
> > > =

> > > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> > > header file.=C2=A0=C2=A0This SVR numberspace is used on some ARM chip=
s as well as
> > > PPC, and even to check for a PPC SVR multi-arch drivers would otherwi=
se
> > > need to ifdef the header inclusion and all references to the SVR symb=
ols.
> > > =

> > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > > [scottwood: update description]
> > > Signed-off-by: Scott Wood <oss@buserror.net>
> > > =

> > As discussed before, please don't introduce yet another vendor specific
> > way to match a SoC ID from a device driver.
> > =

> > I've posted a patch for an extension to the soc_device infrastructure
> > to allow comparing the running SoC to a table of devices, use that
> > instead.
> =

> As I asked before, in which relevant maintainership capacity are you NACK=
ing
> this?

I'll nack the powerpc part until you guys can agree.

cheers
