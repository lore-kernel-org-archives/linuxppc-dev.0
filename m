Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2971DDFB2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:13:45 +1000 (EST)
In-Reply-To: <20070530100438.GB24586@lst.de>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<40815D64-3AD7-49C6-9A58-C7848691D940@kernel.crashing.org>
	<eaf1132805a9531b5131ca51d3e8d9c8@kernel.crashing.org>
	<77D9DB04-FAD3-48EF-9159-5EA92BB366E5@freescale.com>
	<20070530100438.GB24586@lst.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B61C358F-A8D8-4A72-92CC-C770F854F6D5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 07:13:26 -0500
To: Christoph Hellwig <hch@lst.de>
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


On May 30, 2007, at 5:04 AM, Christoph Hellwig wrote:

> On Tue, May 29, 2007 at 02:04:02PM -0500, Becky Bruce wrote:
>> I think that's exactly what Kumar's talking about. The assumption
>> that all 64-bit Power processors will use those upper bits in some
>> meaningful way is not valid.  Also, ld and std do not architecturally
>> "just work" on BookE implementations running in 32b mode.  Those
>> instructions are part of the 64-bit category in 2.03, and may illop
>> on BookE processors running in 32b mode.
>
> Then Bens suggest mode will only work on the sane IBM processors and
> not the braindead freescale ones.  Wouldn't be the first time.

This isn't sane vs braindead.  Its one thing if this was some quirk  
of an implementation, but we are talking about what the architecture  
does and doesn't allow.  There a reasonable reason that a processor  
for the embedded processor would be able to save power in 32-bit mode  
by not powering the upper bits of the register file.

- k
