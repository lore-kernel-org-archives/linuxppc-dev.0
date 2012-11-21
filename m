Return-Path: <21cnbao@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 828172C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 22:02:53 +1100 (EST)
Received: by mail-lb0-f179.google.com with SMTP id gm13so3481546lbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 03:02:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 21 Nov 2012 19:02:28 +0800
Message-ID: <CAGsJ_4y7zFmTZ4c6VsKbzyVsbivFQGXM4uv87obMXyrqfg5HLg@mail.gmail.com>
Subject: Re: [PATCH 207/493] i2c: remove use of __devinit
To: Bill Pemberton <wfp5p@virginia.edu>
Content-Type: text/plain; charset=UTF-8
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 gregkh@linuxfoundation.org, Wolfram Sang <w.sang@pengutronix.de>,
 DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>,
 Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org,
 "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-i2c@vger.kernel.org,
 Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>,
 Jean Delvare <khali@linux-fr.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2012/11/20 Bill Pemberton <wfp5p@virginia.edu>:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: "Ben Dooks " <ben-linux@fluff.org>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Cc: Jochen Friedrich <jochen@scram.de>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Vitaly Wool <vitalywool@gmail.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Acked-by: Barry Song <baohua.song@csr.com>

>  drivers/i2c/busses/i2c-ali1535.c            |  4 ++--
>  drivers/i2c/busses/i2c-ali1563.c            |  4 ++--
>  drivers/i2c/busses/i2c-ali15x3.c            |  4 ++--
>  drivers/i2c/busses/i2c-amd756.c             |  2 +-
>  drivers/i2c/busses/i2c-amd8111.c            |  2 +-
>  drivers/i2c/busses/i2c-at91.c               |  6 +++---
>  drivers/i2c/busses/i2c-au1550.c             |  2 +-
>  drivers/i2c/busses/i2c-cpm.c                |  4 ++--
>  drivers/i2c/busses/i2c-designware-pcidrv.c  |  2 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
>  drivers/i2c/busses/i2c-eg20t.c              |  2 +-
>  drivers/i2c/busses/i2c-elektor.c            |  4 ++--
>  drivers/i2c/busses/i2c-gpio.c               |  4 ++--
>  drivers/i2c/busses/i2c-highlander.c         |  2 +-
>  drivers/i2c/busses/i2c-hydra.c              |  2 +-
>  drivers/i2c/busses/i2c-i801.c               | 14 +++++++-------
>  drivers/i2c/busses/i2c-ibm_iic.c            |  4 ++--
>  drivers/i2c/busses/i2c-intel-mid.c          |  2 +-
>  drivers/i2c/busses/i2c-isch.c               |  2 +-
>  drivers/i2c/busses/i2c-mpc.c                | 20 ++++++++++----------
>  drivers/i2c/busses/i2c-mv64xxx.c            | 12 ++++++------
>  drivers/i2c/busses/i2c-mxs.c                |  2 +-
>  drivers/i2c/busses/i2c-nforce2.c            |  4 ++--
>  drivers/i2c/busses/i2c-nuc900.c             |  2 +-
>  drivers/i2c/busses/i2c-ocores.c             |  2 +-
>  drivers/i2c/busses/i2c-octeon.c             |  6 +++---
>  drivers/i2c/busses/i2c-omap.c               |  2 +-
>  drivers/i2c/busses/i2c-parport-light.c      |  2 +-
>  drivers/i2c/busses/i2c-pasemi.c             |  2 +-
>  drivers/i2c/busses/i2c-pca-isa.c            |  4 ++--
>  drivers/i2c/busses/i2c-pca-platform.c       |  2 +-
>  drivers/i2c/busses/i2c-piix4.c              | 10 +++++-----
>  drivers/i2c/busses/i2c-pmcmsp.c             |  2 +-
>  drivers/i2c/busses/i2c-pnx.c                |  2 +-
>  drivers/i2c/busses/i2c-powermac.c           | 12 ++++++------
>  drivers/i2c/busses/i2c-puv3.c               |  2 +-
>  drivers/i2c/busses/i2c-pxa-pci.c            |  2 +-
>  drivers/i2c/busses/i2c-rcar.c               |  2 +-
>  drivers/i2c/busses/i2c-s6000.c              |  4 ++--
>  drivers/i2c/busses/i2c-sh7760.c             |  4 ++--
>  drivers/i2c/busses/i2c-sirf.c               |  2 +-
>  drivers/i2c/busses/i2c-sis5595.c            |  4 ++--
>  drivers/i2c/busses/i2c-sis630.c             |  4 ++--
>  drivers/i2c/busses/i2c-sis96x.c             |  2 +-
>  drivers/i2c/busses/i2c-tegra.c              |  2 +-
>  drivers/i2c/busses/i2c-via.c                |  2 +-
>  drivers/i2c/busses/i2c-viapro.c             |  2 +-
>  drivers/i2c/busses/i2c-xiic.c               |  2 +-
>  drivers/i2c/busses/i2c-xlr.c                |  2 +-
>  drivers/i2c/busses/scx200_acb.c             | 10 +++++-----
>  drivers/i2c/muxes/i2c-mux-gpio.c            |  4 ++--
>  drivers/i2c/muxes/i2c-mux-pinctrl.c         |  2 +-
>  52 files changed, 103 insertions(+), 103 deletions(-)
>
