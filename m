Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59ED4DDF9B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 04:41:01 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8PIeMiF027001
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:40:22 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m8PIeLJb014717
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 13:40:21 -0500 (CDT)
Date: Thu, 25 Sep 2008 13:40:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
Message-ID: <20080925184020.GA5230@ld0162-tx32.am.freescale.net>
References: <1222293567-17694-1-git-send-email-timur@freescale.com>
	<2a27d3730809242354u4cc24b96yda3973bfc3ddac92@mail.gmail.com>
	<48DB9816.4020603@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48DB9816.4020603@freescale.com>
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
	Li Yang <leoli@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 08:54:30AM -0500, Timur Tabi wrote:
> Li Yang wrote:
> 
> >> -subsys_initcall(of_fsl_dma_chan_init);
> >>  subsys_initcall(of_fsl_dma_init);
> > 
> > Not a critical problem.  But module_init() are preferred for modules.
> 
> This was intentional.  When compiled as a module, subsys_initcall becomes
> module_init().  When compiled in-kernel, this code is initialized before most
> drivers, so it's ready when the drivers are loaded.

If there's a dependency there, how will it work when this is built as a
module?

-Scott
