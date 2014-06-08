Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com
 [IPv6:2a00:1450:400c:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D6431A00CF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jun 2014 04:49:02 +1000 (EST)
Received: by mail-we0-f169.google.com with SMTP id w61so2176065wes.28
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jun 2014 11:48:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1400924009-23992-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1400924009-23992-1-git-send-email-a13xp0p0v88@gmail.com>
Date: Sun, 8 Jun 2014 22:48:58 +0400
Message-ID: <CAF0T0X5OQH8SED5a0JreZw8wNs2R-2c2v5=7F4v4up5viK3aYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: mpc512x: add device tree binding document
 and DMA channel lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2014-05-24 13:33 GMT+04:00 Alexander Popov <a13xp0p0v88@gmail.com>:
> This patch series introduces a device tree binding document for
> the MPC512x DMA controller and adds device tree based DMA channel lookup
> for it.

Hello, excuse me, could I have a feedback?
Should I fix anything?

Thanks a lot!
Alexander

> Alexander Popov (3):
>   dmaengine: mpc512x: add device tree binding document
>   dmaengine: of: add common xlate function for matching by channel id
>   dmaengine: mpc512x: register for device tree channel lookup
>
>  .../devicetree/bindings/dma/mpc512x-dma.txt        | 40 ++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc5121.dtsi                 |  1 +
>  drivers/dma/mpc512x_dma.c                          | 13 ++++++-
>  drivers/dma/of-dma.c                               | 35 +++++++++++++++++++
>  include/linux/of_dma.h                             |  4 +++
>  5 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>
> --
> 1.8.4.2
>
