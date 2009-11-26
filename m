Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B7811007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:13:49 +1100 (EST)
Subject: Re: [RFC PATCH 16/19] powerpc: wii: hollywood interrupt controller
	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0EA1E8.6070603@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
	<1259213022.16367.273.camel@pasglop>  <4B0EA1E8.6070603@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 08:13:44 +1100
Message-ID: <1259270024.18084.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 16:42 +0100, Albert Herranz wrote:
> Benjamin Herrenschmidt wrote:
> > On Sun, 2009-11-22 at 23:01 +0100, Albert Herranz wrote:
> > 
> >> +static void hlwd_pic_mask_and_ack(unsigned int virq)
> >> +{
> >> +	int irq = virq_to_hw(virq);
> >> +	void __iomem *io_base = get_irq_chip_data(virq);
> >> +
> >> +	clear_bit(irq, io_base + HW_BROADWAY_IMR);
> >> +	set_bit(irq, io_base + HW_BROADWAY_ICR);
> >> +}
> > 
> > Same comment as with flipper. BTW. It looks really similar, can't you
> > use the same driver ?
> > 
> 
> I'll look at it. Surely, parts of it would be mergeable.

If it's too much work, we can do that later. No big deal.

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> 
> Thanks,
> Albert
> 
> > 
> > 
