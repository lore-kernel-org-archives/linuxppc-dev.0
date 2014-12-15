Return-Path: <festevam@gmail.com>
Received: from mail-lb0-x229.google.com (mail-lb0-x229.google.com
 [IPv6:2a00:1450:4010:c04::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C0E51A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 10:13:28 +1100 (AEDT)
Received: by mail-lb0-f169.google.com with SMTP id p9so10138082lbv.28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 15:13:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
Date: Mon, 15 Dec 2014 21:13:23 -0200
Message-ID: <CAOMZO5Cr9kN9ZbCLkt0nOhWbUf9wJ+RHr31Fct-pSw0yEQDKPA@mail.gmail.com>
Subject: Re: PROBLEM: USB isochronous urb leak on EHCI driver
From: Fabio Estevam <festevam@gmail.com>
To: Michael Tessier <michael.tessier@axiontech.ca>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 15, 2014 at 6:53 PM, Michael Tessier
<michael.tessier@axiontech.ca> wrote:

> Before attempting to upgrade to an earlier kernel driver (this is
> a fairly big amount of work), I would really like to know if this
> problem would still be in the 3.x kernels. Has anyone seen that
> issue in 3.x kernels?

In fact it is very simple to test USB on a 3.18 kernel with your hardware.

You only need a minimal dts file with the usb/serial nodes enabled.

Take a loot at arch/arm/boot/dts/imx51-babbage.dts for a reference.

I tested USB earlier today on this board with 3.18 and it worked fine.
You need this patch:
http://www.spinics.net/lists/arm-kernel/msg385739.html

Regards,

Fabio Estevam
