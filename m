Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2301DDF29
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 02:08:32 +1100 (EST)
Date: Thu, 20 Mar 2008 10:08:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
Message-ID: <20080320150823.GB31587@ld0162-tx32.am.freescale.net>
References: <200803071521.00383.laurentp@cse-semaphore.com>
	<200803101317.04455.laurentp@cse-semaphore.com>
	<20080317153326.GA2644@loki.buserror.net>
	<200803201439.59806.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803201439.59806.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 02:39:56PM +0100, Laurent Pinchart wrote:
> I'm working on a patch. I'm not sure how to handle the early udbg printk 
> problem, so the first version will just ignore it.

udbg printk is extremely useful... I'd not be fond of it breaking.

Perhaps we should stick more initialization into the cpm udbg code, so it
isn't so dependent on the bootloader setup... though we'd have push the
CPM reset and SMC allocation earlier in such a case.

-Scott
