Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 996A2B6F81
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jul 2011 23:59:29 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: GPIO IRQ on P1022
Date: Sun, 31 Jul 2011 13:59:20 +0000
Message-ID: <4E355FB7.3030904@freescale.com>
References: <4E35309E.4000202@embedded-sol.com>
In-Reply-To: <4E35309E.4000202@embedded-sol.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix Radensky wrote:
>
>      What happens when I load my driver is single execution of interrupt
> handler
>      followed by system freeze. Even if I call disable_irq() in interrupt
> handler the
>      system still freezes.

I don't know anything about the GPIO layer, but I think you're going to=20
need to debug this a little more.  Where exactly is the freeze?  Are you=20
sure the interrupt handler is being called only once?  Perhaps you're not=20
clearing the interrupt status and your handler is being called repeatedly?

--=20
Timur Tabi
Linux kernel developer at Freescale=
