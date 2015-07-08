Return-Path: <robert.jarzmik@free.fr>
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 027431A1137
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 05:29:02 +1000 (AEST)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
 linux-usb@vger.kernel.org, m.szyprowski@samsung.com,
 linux-arm-kernel@lists.infradead.org, johnyoun@synopsys.com,
 linuxppc-dev@lists.ozlabs.org, cernekee@gmail.com, nicolas.ferre@atmel.com,
 michal.simek@xilinx.com, balbi@ti.com, linux-kernel@vger.kernel.org,
 haojian.zhuang@gmail.com, linux-omap@vger.kernel.org, Peter.Chen@freescale.com,
 dahlmann.thomas@arcor.de, andrzej.p@samsung.com, leoli@freescale.com,
 daniel@zonque.org, linux-geode@lists.infradead.org
Subject: Re: [PATCH 28/37] usb: gadget: pxa27x_udc: add ep capabilities support
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
 <1436353761-7107-29-git-send-email-r.baldyga@samsung.com>
Date: Wed, 08 Jul 2015 21:26:08 +0200
In-Reply-To: <1436353761-7107-29-git-send-email-r.baldyga@samsung.com> (Robert
 Baldyga's message of "Wed, 08 Jul 2015 13:09:12 +0200")
Message-ID: <874mlea1tb.fsf@belgarion.home>
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

Robert Baldyga <r.baldyga@samsung.com> writes:

> Convert endpoint configuration to new capabilities model.
The commit message is very short to judge the patch's correctness.

I'll side up with Felipe's opinion. If it's fine by him, so it is by me.

Cheers.

--
Robert
