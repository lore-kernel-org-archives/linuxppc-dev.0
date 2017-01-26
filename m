Return-Path: <robert.jarzmik@free.fr>
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8GV74PzhzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 20:15:27 +1100 (AEDT)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, balbi@kernel.org, gregkh@linuxfoundation.org,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: gadget: udc: constify usb_ep_ops structures
References: <1485192364-2840-1-git-send-email-bhumirks@gmail.com>
Date: Thu, 26 Jan 2017 10:15:04 +0100
In-Reply-To: <1485192364-2840-1-git-send-email-bhumirks@gmail.com> (Bhumika
 Goyal's message of "Mon, 23 Jan 2017 22:56:04 +0530")
Message-ID: <878tpychd3.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bhumika Goyal <bhumirks@gmail.com> writes:

> Declare usb_ep_ops structures as const as they are only stored in the
> ops field of an usb_ep structure. This field is of type const, so
> usb_ep_ops structures having this property can be made const too.
> Done using Coccinelle( A smaller version of the script)

For pxa27x_udc.c :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
