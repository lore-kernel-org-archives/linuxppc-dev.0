Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4106DDDFFC
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 20:04:50 +1000 (EST)
Date: Wed, 30 May 2007 12:04:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: Saving to 32 bits of GPRs in signal context
Message-ID: <20070530100438.GB24586@lst.de>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<40815D64-3AD7-49C6-9A58-C7848691D940@kernel.crashing.org>
	<eaf1132805a9531b5131ca51d3e8d9c8@kernel.crashing.org>
	<77D9DB04-FAD3-48EF-9159-5EA92BB366E5@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <77D9DB04-FAD3-48EF-9159-5EA92BB366E5@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 02:04:02PM -0500, Becky Bruce wrote:
> I think that's exactly what Kumar's talking about. The assumption  
> that all 64-bit Power processors will use those upper bits in some  
> meaningful way is not valid.  Also, ld and std do not architecturally  
> "just work" on BookE implementations running in 32b mode.  Those  
> instructions are part of the 64-bit category in 2.03, and may illop  
> on BookE processors running in 32b mode.

Then Bens suggest mode will only work on the sane IBM processors and
not the braindead freescale ones.  Wouldn't be the first time.
