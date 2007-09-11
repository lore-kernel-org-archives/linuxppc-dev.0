Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 28554DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:20:32 +1000 (EST)
Date: Tue, 11 Sep 2007 09:20:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
Message-ID: <20070911142014.GG1932@ld0162-tx32.am.freescale.net>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<BAE9DCEF64577A439B3A37F36F9B691C02FF08A1@orsmsx418.amr.corp.intel.com>
	<46B96294322F7D458F9648B60E15112C85D61E@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46B96294322F7D458F9648B60E15112C85D61E@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com, "Nelson,
	Shannon" <shannon.nelson@intel.com>, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 06:10:53PM +0800, Zhang Wei-r63237 wrote:
> > >+
> > >+	fsl_dma_memcpy_issue_pending(chan);
> > >+	while (fsl_dma_is_complete(chan, cookie, NULL, NULL)
> > >+			!= DMA_SUCCESS);
> > 
> > Again, is it possible to hang your thread here?
> > 
> > [...]
> 
> I'll add msleep here.

I think what was being sought was a timout, causing the test to return
failure.

-Scott
