Return-Path: <robert.jarzmik@free.fr>
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126]) by ozlabs.org (Postfix) with ESMTP id B67FF2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 07:18:46 +1100 (EST)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage
 gadget->dev
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-30-git-send-email-balbi@ti.com>
Date: Mon, 28 Jan 2013 21:18:29 +0100
In-Reply-To: <1359042370-4358-30-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Thu, 24 Jan 2013 17:46:07 +0200")
Message-ID: <87txq1m57u.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 Linux USB Mailing List <linux-usb@vger.kernel.org>, nicolas.ferre@atmel.com,
 linux-geode@lists.infradead.org, haojian.zhuang@gmail.com,
 linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org,
 dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felipe Balbi <balbi@ti.com> writes:

> By simply setting a flag, we can drop some
> boilerplate code.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/pxa27x_udc.c | 9 +--------
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

And I tested also your patch and it works in my environment. For next patches
I'd like to be CCed for pxa27x_udc stuff as I'm maintaining that one since its
beginning (and yes, I know, I didn't put that in MAINTAINERS ...).

Cheers.

--
Robert
