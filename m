Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8CD0B1400A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 15:47:00 +1000 (EST)
Received: by mail-wg0-f46.google.com with SMTP id n12so159876wgh.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 22:46:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
Date: Wed, 30 Apr 2014 09:46:54 +0400
Message-ID: <CAF0T0X7=dEE0Cs=EjOm0GoLspiZa7uOPQDk9qr9U7ircRxnmNw@mail.gmail.com>
Subject: Re: [PATCH RFC v12 0/7] MPC512x DMA slave s/g support, OF DMA lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello

2014-04-23 17:53 GMT+04:00 Alexander Popov <a13xp0p0v88@gmail.com>:
> Changes in v12:
>  A new patch (part 2/7) is added to this series.
>  Part 6/7:
>  - change the description of 'compatible' property according part 2/7;
>  - improve the document according Gerhard's feedback;

Could I have a feedback? Is the binding document fine now?
Thanks!

> Alexander Popov (7):
>   dma: mpc512x: reorder mpc8308 specific instructions
>   dma: mpc512x: separate 'compatible' values for MPC512x and MPC8308
>   dma: mpc512x: add support for peripheral transfers
>   dma: mpc512x: fix freeing resources in mpc_dma_probe() and
>     mpc_dma_remove()
>   dma: of: add common xlate function for matching by channel id
>   dma: mpc512x: add device tree binding document
>   dma: mpc512x: register for device tree channel lookup
>
>  .../devicetree/bindings/dma/mpc512x-dma.txt        |  40 +++
>  arch/powerpc/boot/dts/mpc5121.dtsi                 |   1 +
>  arch/powerpc/boot/dts/mpc8308_p1m.dts              |   2 +-
>  arch/powerpc/boot/dts/mpc8308rdb.dts               |   2 +-
>  drivers/dma/mpc512x_dma.c                          | 346 ++++++++++++++++++---
>  drivers/dma/of-dma.c                               |  35 +++
>  include/linux/of_dma.h                             |   4 +
>  7 files changed, 390 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>
> --
> 1.8.4.2
>

Best regards,
Alexander
