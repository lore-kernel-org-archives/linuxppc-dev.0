Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 1C12A679E1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 01:29:32 +1000 (EST)
Message-ID: <453CDFDA.6090104@freescale.com>
Date: Mon, 23 Oct 2006 10:29:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
References: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>	<17724.15919.790114.628418@cargo.ozlabs.ibm.com>
	<453CDD70.9010100@freescale.com>
In-Reply-To: <453CDD70.9010100@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Note that many/most interrupt controller drivers don't even do that 
> much; they just have more fortuitous timing than the QE (and/or the 
> spurious interrupt is non-cascaded, and thus gets caught in 
> handle_level_irq and doesn't increment the spurious interrupt count).

Ignore that last bit about non-cascaded interrupts; if it makes a 
difference at all, it's because of added delays (getting back to the 
fortuitous timing thing).

-Scott
