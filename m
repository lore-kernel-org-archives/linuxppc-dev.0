Return-Path: <linus.walleij@linaro.org>
Received: from mail-ob0-x233.google.com (mail-ob0-x233.google.com
 [IPv6:2607:f8b0:4003:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FEDC2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 07:19:48 +1000 (EST)
Received: by mail-ob0-f179.google.com with SMTP id xk17so1879604obc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 14:19:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACxGe6tW+k6dN6gi6MoPQ2zehP4R+THmzFGZQkhOZGH7oS+S2g@mail.gmail.com>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
 <1370825362-11145-11-git-send-email-grant.likely@linaro.org>
 <CACRpkda+WD5dMoZ9s7mTLgOgUrm+EH3Mqxio=BuLTDr3aOEruw@mail.gmail.com>
 <CACxGe6tW+k6dN6gi6MoPQ2zehP4R+THmzFGZQkhOZGH7oS+S2g@mail.gmail.com>
Date: Sat, 15 Jun 2013 23:19:43 +0200
Message-ID: <CACRpkdZcnjwQNap=i+LvzEeEFwDFgHw2BD7KVAUCNh0mRtX26w@mail.gmail.com>
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

On Mon, Jun 10, 2013 at 12:50 PM, Grant Likely <grant.likely@linaro.org> wrote:
> On Mon, Jun 10, 2013 at 8:40 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, Jun 10, 2013 at 2:49 AM, Grant Likely <grant.likely@linaro.org> wrote:
>>
>>> This is an RFC patch to convert the versatile FPGA irq controller driver
>>> to use generic irq chip. It builds on the series that extends the
>>> generic chip code to allow a linear irq domain to contain one or more
>>> generic irq chips so that each interrupt controller doesn't need to hand
>>> code the generic chip setup.
>>>
>>> I've written this as a proof of concept to see if the new generic irq
>>> code does what it needs to. I had to extend it slightly to properly
>>> handle the valid mask used by the versatile FPGA driver.
>>>
>>> Tested on QEMU, but not on real hardware.
>>
>> Is this the same as the one I tested previously?
>>
>> If it need re-testing please push a branch and I'll take it
>> for a spin.
>
> Yes, it's the same, but if you can test the branch I would appreciate
> it. I've done some heavy rework on the irqdomain code that makes
> everything simpler, but also makes it likely that I've broken
> something.
>
> git://git.secretlab.ca/git/linux.git irqdomain/test

It still works like a charm on the Integrator/AP.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
