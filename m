Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D5AEDDF77
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 22:39:00 +1100 (EST)
Date: Thu, 22 Mar 2007 12:38:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
Message-ID: <20070322113857.GA13547@lst.de>
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<200703170909.13869.sr@denx.de>
	<e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
	<200703171943.27465.sr@denx.de>
	<e9c3a7c20703171209m55fd9dfsbba0e4fff5c6350d@mail.gmail.com>
	<1174320799.5044.21.camel@localhost.localdomain>
	<582f77296616b0b85ff7533bb7fea05c@kernel.crashing.org>
	<1174506924.10836.2.camel@localhost.localdomain>
	<0e5aac2ffcd189dc51f59d5891b2366c@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e5aac2ffcd189dc51f59d5891b2366c@kernel.crashing.org>
Cc: linux-raid@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Dan Williams <dan.j.williams@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 09:03:27PM +0100, Segher Boessenkool wrote:
> >>> BTW folks. Would it be hard to change your spe_ prefixes to something
> >>> else ? There's already enough confusion between the freescale SPE 
> >>> unit
> >>> and the cell SPEs :-)
> >>
> >> Will you change _your_ prefixes too?  :-) :-)
> >
> > Which ones ? I'm not in charge of the fsl spe thingy nor the spe
> > scheduler code :-)
> 
> I meant the Cell code of course.

Did you ever take a look at the cell code?  The only place 'spe'
is used in a prefix are a handfull of hardware datatstructures and the
sony crap hypervisor hvcalls.  Everything else uses spu_ as a prefix.

But yeah, grep is hard and life is a bitch.. :)
