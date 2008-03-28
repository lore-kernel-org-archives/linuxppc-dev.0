Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52FFFDE047
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 02:22:42 +1100 (EST)
Date: Fri, 28 Mar 2008 10:22:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Message-ID: <20080328152233.GA7456@ld0162-tx32.am.freescale.net>
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<20080327153952.GC18728@ld0162-tx32.am.freescale.net>
	<200803281458.56766.laurentp@cse-semaphore.com>
	<200803281506.58988.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803281506.58988.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 03:06:58PM +0100, Laurent Pinchart wrote:
> arch/powerpc/boot/cpm-serial.c stores the udbg buffer descriptors at the 
> beginning of the muram. Should I move them at the end as well ?

Sure; make sure to update the default descriptor addresses in the
Kconfig.

-Scott
