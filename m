Return-Path: <adrian@humboldt.co.uk>
Subject: Re: linux DMA capabilities in MV64460
From: Adrian Cox <adrian@humboldt.co.uk>
To: Phil.Nitschke@avalon.com.au
In-Reply-To: <kwlkvomcxp.fsf@lamorak.int.avalon.com.au>
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
	<20051220010136.GA31165@mag.az.mvista.com>
	<kwlkvomcxp.fsf@lamorak.int.avalon.com.au>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 22:36:18 +0000
Message-Id: <1141857378.28095.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-03-06 at 14:39 +1030, Phil Nitschke wrote:
> How is a DMA controlled (from a device driver writer's perspective) when
> a third-party (i.e. in the bridge) DMA controller needs to do the work
> to get the data from a PCI Target into main memory?
> 
> What kernel API should be provided by the DMA Controller Driver?  

There is no current API for this in the kernel, but there are some
proposals. From Intel, we have I/OAT, which targets network operations:
http://lkml.org/lkml/2006/3/3/219

There's some overlap with the ADMA feature set, which is intended to
accelerate RAID operations:
http://lkml.org/lkml/2006/2/2/442


-- 
Adrian Cox <adrian@humboldt.co.uk>
