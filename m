Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60B0CDE027
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 02:27:37 +1100 (EST)
Date: Thu, 3 Apr 2008 10:27:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Message-ID: <20080403152722.GF6857@ld0162-tx32.am.freescale.net>
References: <20080311191744.GA10518@localhost.localdomain>
	<200804031545.51834.laurentp@cse-semaphore.com>
	<20080403143052.GA5955@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080403143052.GA5955@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	David Brownell <david-b@pacbell.net>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 06:30:52PM +0400, Anton Vorontsov wrote:
> On Thu, Apr 03, 2008 at 03:45:47PM +0200, Laurent Pinchart wrote:
> > At first sight the driver depends on qe_lib for:
> > 
> > - muram allocation (qe_muram_alloc/free, qe_muram_offset/addr)
> 
> Yeah, I already posted a patch to deal with it, see
> http://ozlabs.org/pipermail/linuxppc-dev/2008-March/053249.html
> (btw... Scott, Timur did you have a chance to look into this?)

It looks fine to me.

> > It shouldn't be too difficult to abstract those operation in a fashion similar 
> > to the cpm_uart driver.
> 
> Yup, but we still have ucc_serial (QE) and cpm_uart (CPM1/2) drivers as
> separate matters though. ;-) I didn't look for the reasons of this split
> but I assume there are and they're strong enough.

Not really. :-)

The reason was because the work hasn't been done yet to merge the
infrastructure for CPM and QE.

-Scott
