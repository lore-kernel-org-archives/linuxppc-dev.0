Return-Path: <benh@kernel.crashing.org>
Subject: Re: EMAC device-tree binding (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070202011214.GC3913@localhost.localdomain>
References: <1170118707.26655.299.camel@localhost.localdomain>
	<20070202011214.GC3913@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 04 Feb 2007 15:40:09 +1100
Message-Id: <1170564011.2620.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-02 at 12:12 +1100, David Gibson wrote:
> On Tue, Jan 30, 2007 at 11:58:27AM +1100, Benjamin Herrenschmidt wrote:
> > According to the various comments I got, here's the latest binding for
> > EMAC:
> 
> [snip]
> >  - cell-index        : 1 cell, hardware index of the EMAC cell on a given ASIC (typically
> >                        0x00000000 and 0x00000001 for EMAC-0 and EMAC-1 on each Axon chip)
> 
> I noticed that some of the Freescale device trees used a property
> called 'device-id' for what appears to be the same thing as this on
> their UCC.  Maybe we should use that name for EMAC and the other 4xx
> devices as well?

Hrm... I don't like that much... device-id is a standard property for
PCI devices and has a totally different meaning.

Ben.
