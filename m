Return-Path: <linus.walleij@linaro.org>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 260682C02FF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 17:40:13 +1000 (EST)
Received: by mail-ob0-f181.google.com with SMTP id 16so9577836obc.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 00:40:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370825362-11145-11-git-send-email-grant.likely@linaro.org>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
 <1370825362-11145-11-git-send-email-grant.likely@linaro.org>
Date: Mon, 10 Jun 2013 09:40:08 +0200
Message-ID: <CACRpkda+WD5dMoZ9s7mTLgOgUrm+EH3Mqxio=BuLTDr3aOEruw@mail.gmail.com>
Subject: Re: [RFC 10/10] irqchip: Make versatile fpga irq driver a generic chip
From: Linus Walleij <linus.walleij@linaro.org>
To: Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 10, 2013 at 2:49 AM, Grant Likely <grant.likely@linaro.org> wrote:

> This is an RFC patch to convert the versatile FPGA irq controller driver
> to use generic irq chip. It builds on the series that extends the
> generic chip code to allow a linear irq domain to contain one or more
> generic irq chips so that each interrupt controller doesn't need to hand
> code the generic chip setup.
>
> I've written this as a proof of concept to see if the new generic irq
> code does what it needs to. I had to extend it slightly to properly
> handle the valid mask used by the versatile FPGA driver.
>
> Tested on QEMU, but not on real hardware.

Is this the same as the one I tested previously?

If it need re-testing please push a branch and I'll take it
for a spin.

Yours.
Linus Walleij
