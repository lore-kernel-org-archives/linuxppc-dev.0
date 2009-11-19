Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 18239B6F0E
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 08:49:00 +1100 (EST)
Message-ID: <4B05BD40.1080701@am.sony.com>
Date: Thu, 19 Nov 2009 13:48:48 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] powerpc: Fixup last users of irq_chip->typename - V2
References: <20091117224852.846805939@linutronix.de>	<20091117224916.566205413@linutronix.de>	<20091118175523.GA12857@b07421-ec1.am.freescale.net>	<alpine.LFD.2.00.0911182141060.24119@localhost.localdomain>
	<alpine.LFD.2.00.0911191035030.24119@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0911191035030.24119@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/19/2009 01:44 AM, Thomas Gleixner wrote:
> The typename member of struct irq_chip was kept for migration purposes
> and is obsolete since more than 2 years. Fix up the leftovers.

> Index: linux-2.6-tip/arch/powerpc/platforms/ps3/interrupt.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/powerpc/platforms/ps3/interrupt.c
> +++ linux-2.6-tip/arch/powerpc/platforms/ps3/interrupt.c
> @@ -152,7 +152,7 @@ static void ps3_chip_eoi(unsigned int vi
>   */
> 
>  static struct irq_chip ps3_irq_chip = {
> -       .typename = "ps3",
> +       .name = "ps3",
>         .mask = ps3_chip_mask,
>         .unmask = ps3_chip_unmask,
>         .eoi = ps3_chip_eoi,


This PS3 part looks OK.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
