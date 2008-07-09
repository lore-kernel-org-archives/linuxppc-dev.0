Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CAC8DE1B2
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 06:43:56 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix problems with 32bit PPC's running with
	more than 2GB of RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080709162219.4c07a67e@zod.rchland.ibm.com>
References: <1215611076-13518-1-git-send-email-sr@denx.de>
	<1215633758.8970.372.camel@pasglop>
	<20080709162219.4c07a67e@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Jul 2008 06:39:39 +1000
Message-Id: <1215635979.8970.385.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 16:22 -0400, Josh Boyer wrote:
> On Thu, 10 Jul 2008 06:02:38 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2008-07-09 at 15:44 +0200, Stefan Roese wrote:
> > > This patch enables 32bit PPC's (with 36bit physical address space, e.g.
> > > IBM/AMCC PPC44x) to run with more than 2GB of RAM. Mostly its just
> > > replacing types (unsigned long -> phys_addr_t).
> > > 
> > > Tested on an AMCC Katmai with 4GB of DDR2.
> > > 
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> > 
> > But DMAs will break no ?
> 
> How?

Hrm... forget it. It's fine up to 4G of RAM... (ie. as long as DMA is
below 32 bits).

Ben.
