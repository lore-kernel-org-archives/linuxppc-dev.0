Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DEC067E82
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 06:24:30 +1100 (EST)
Date: Mon, 20 Nov 2006 20:23:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
Message-ID: <20061120192335.GA3372@elte.hu>
References: <4561C9EC.3020506@ru.mvista.com> <20061120165621.GA1504@elte.hu>
	<4561DFE1.4020708@ru.mvista.com> <20061120172642.GA8683@elte.hu>
	<20061120175502.GA12733@elte.hu> <4561F43B.40000@ru.mvista.com>
	<20061120191013.GA30828@elte.hu> <20061120191149.GA32537@elte.hu>
	<4561FF9D.9040903@ru.mvista.com> <45620108.6020705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45620108.6020705@ru.mvista.com>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >>	if (redirect_hardirq(desc)) {
> >>-		mask_ack_irq(desc, irq);
> >>-		goto out_unlock;
> 
>    That label would generate a warning though. Should be gotten rid of now.

yep, gone in my tree.

	Ingo
