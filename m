Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5F04DDD05
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 02:09:00 +1000 (EST)
Date: Fri, 14 Sep 2007 11:08:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 1/2] [POWERPC] Add SCC clock support to cpm2_clk_setup()
Message-ID: <20070914160847.GA6884@ld0162-tx32.am.freescale.net>
References: <200707111517.52663.laurent.pinchart@technotrade.biz>
	<200709141755.45559.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709141755.45559.laurentp@cse-semaphore.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 05:55:45PM +0200, Laurent Pinchart wrote:
> > On Sep 13, 2007, at 8:53 AM, Laurent Pinchart wrote:
> >> On Wednesday 11 July 2007 15:17, Laurent Pinchart wrote:
> >>> cpm2_clk_setup() supports setting FCC clocks only, even though the
> >>> cpm_clk_target enumeration lists SCC clocks. This patch adds SCC  
> >>> clock support.
> >>
> >> Any chance this patch (and its 2/2 brother) could be committed ?
> >
> > Have you looked at Scott Wood's cleanup patches.  They seem to do  
> > some of this.
> 
> Where can I find them ? I checked in
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> 
> and found nothing relevant.

Check the linuxppc-dev archives... I should have another respin soon
(hopefully today).

-Scott
