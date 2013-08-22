Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BE032C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:38:24 +1000 (EST)
Message-ID: <1377207495.20722.11.camel@snotra.buserror.net>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
From: Scott Wood <scottwood@freescale.com>
To: Saravanan S <sarans1987@gmail.com>
Date: Thu, 22 Aug 2013 16:38:15 -0500
In-Reply-To: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-22 at 21:04 +0530, Saravanan S wrote:

> a)   I can generate MSI interrupts from End Point to Root Complex over
> PCI . But the vice-versa is not possible . However i need a method to
> interrupt the End Point from the Root Complex to complete my driver.
> Only previous references I can find are this post
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg25765.html . However this uses doorbells and I think may not be possible in MPC8640.

You should be able to write to the destination's MPIC registers to send
a doorbell.

-Scott
