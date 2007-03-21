Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0180DDF64
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 06:55:39 +1100 (EST)
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <582f77296616b0b85ff7533bb7fea05c@kernel.crashing.org>
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<200703170909.13869.sr@denx.de>
	<e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
	<200703171943.27465.sr@denx.de>
	<e9c3a7c20703171209m55fd9dfsbba0e4fff5c6350d@mail.gmail.com>
	<1174320799.5044.21.camel@localhost.localdomain>
	<582f77296616b0b85ff7533bb7fea05c@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 06:55:24 +1100
Message-Id: <1174506924.10836.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-raid@vger.kernel.org, Dan Williams <dan.j.williams@gmail.com>,
	Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-21 at 15:10 +0100, Segher Boessenkool wrote:
> > BTW folks. Would it be hard to change your spe_ prefixes to something
> > else ? There's already enough confusion between the freescale SPE unit
> > and the cell SPEs :-)
> 
> Will you change _your_ prefixes too?  :-) :-)

Which ones ? I'm not in charge of the fsl spe thingy nor the spe
scheduler code :-) Beside, that code is already in vs. new code getting
in. Thus I fail to see your point.

Ben.
