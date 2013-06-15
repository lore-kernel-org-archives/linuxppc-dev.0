Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 472DB2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 08:48:46 +1000 (EST)
Received: by mail-ie0-f182.google.com with SMTP id s9so4152436iec.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 15:48:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <CACRpkda2isXNCrd8Auiv7bNtKYBH3cwRx6idebMDbDPZrbqfJQ@mail.gmail.com>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
 <1370825362-11145-11-git-send-email-grant.likely@linaro.org>
 <CACRpkda+WD5dMoZ9s7mTLgOgUrm+EH3Mqxio=BuLTDr3aOEruw@mail.gmail.com>
 <CACxGe6tW+k6dN6gi6MoPQ2zehP4R+THmzFGZQkhOZGH7oS+S2g@mail.gmail.com>
 <CACRpkdZcnjwQNap=i+LvzEeEFwDFgHw2BD7KVAUCNh0mRtX26w@mail.gmail.com>
 <CACRpkda2isXNCrd8Auiv7bNtKYBH3cwRx6idebMDbDPZrbqfJQ@mail.gmail.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Sat, 15 Jun 2013 23:48:22 +0100
Message-ID: <CACxGe6tvSptNKJMz6eUXwahH0VbXVgnjdj2ARD1BfLiS-x6z_Q@mail.gmail.com>
Subject: Re: [RFC 10/10] irqchip: Make versatile fpga irq driver a generic chip
To: Linus Walleij <linus.walleij@linaro.org>
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

On Sat, Jun 15, 2013 at 10:22 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Sat, Jun 15, 2013 at 11:19 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> It still works like a charm on the Integrator/AP.
>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>
> BTW here is the new hwirq output in /proc/interrupts and it's really nice:
>
> root@integrator:/proc cat interrupts
>            CPU0
>  17:       1845       pic   1  uart-pl010
>  22:      13716       pic   6  timer
>  24:          0       pic   8  rtc-pl030
> Err:          0

Glad you like it. :-)

g.
