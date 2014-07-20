Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FCB61A0209
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 05:18:09 +1000 (EST)
Received: by mail-wg0-f48.google.com with SMTP id x13so5593360wgg.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jul 2014 12:18:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1403693580-9449-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1403693580-9449-1-git-send-email-a13xp0p0v88@gmail.com>
Date: Sun, 20 Jul 2014 23:18:04 +0400
Message-ID: <CAF0T0X62_uwG7z8ZKtn7C=OsRCRfbBBE8QKb3tpju0zvSZf8Fg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] dmaengine: mpc512x: add device tree binding
 document and DMA channel lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

2014-06-25 14:52 GMT+04:00 Alexander Popov <a13xp0p0v88@gmail.com>:
> This patch series introduces a device tree binding document for
> the MPC512x DMA controller and adds device tree based DMA channel lookup
> for it.
>
> This version contains the improved device tree binding document:
> #dma-cells is made a required property, as it must be according
> dma/dma.txt document.

Could I have a feedback, please?
Thanks!

> Alexander Popov (3):
>   dmaengine: mpc512x: add device tree binding document
>   dmaengine: of: add common xlate function for matching by channel id
>   dmaengine: mpc512x: register for device tree channel lookup
>
>  .../devicetree/bindings/dma/mpc512x-dma.txt        | 29 ++++++++++++++++++
>  arch/powerpc/boot/dts/mpc5121.dtsi                 |  1 +
>  drivers/dma/mpc512x_dma.c                          | 13 +++++++-
>  drivers/dma/of-dma.c                               | 35 ++++++++++++++++++++++
>  include/linux/of_dma.h                             |  4 +++
>  5 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>
> --
> 1.8.4.2
>
