Return-Path: <kalluripunnaiahchoudary@gmail.com>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9A8F5140080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 14:53:36 +1000 (EST)
Received: by mail-lb0-f180.google.com with SMTP id 10so2788999lbg.25
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Apr 2014 21:53:30 -0700 (PDT)
MIME-Version: 1.0
Sender: kalluripunnaiahchoudary@gmail.com
In-Reply-To: <5354175B.3070109@pengutronix.de>
References: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
 <5354175B.3070109@pengutronix.de>
Date: Mon, 21 Apr 2014 10:23:30 +0530
Message-ID: <CAGnW=Bav_Q_ZpkFq0gG7m9+OBnPWyPhOoBTNnP=VdErzcwe2dQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb
 controller
From: punnaiah choudary kalluri <punnaia@xilinx.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux-usb@vger.kernel.org,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>, balbi@ti.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Punnaiah Choudary <kpc528@gmail.com>, Peter Chen <peter.chen@freescale.com>,
 Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2014 at 12:22 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04/20/2014 06:27 PM, Punnaiah Choudary Kalluri wrote:
>> Zynq soc contains a dual role usb controller and this IP is from synopsys. We
>> observed that there is driver available for this controller from freescale and
>> decided to reuse this driver for zynq use.
>
> Have a look drivers/usb/chipidea. It's maintained by Peter Chen (Cc'ed)
> and is in better shape than the freescale driver.

Thanks. I will check this implementation and also check with Peter Chen if
i have any concerns about this implementation.

Punnaiah.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
