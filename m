Return-Path: <dgibson@ozlabs.org>
Date: Mon, 27 Aug 2007 11:55:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Message-ID: <20070827015509.GC12804@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092954.4087.95333.stgit@localhost.localdomain>
	<67f53d72d17c98f2b8a76ec42195c0aa@kernel.crashing.org>
	<20070826142750.0a6a228e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070826142750.0a6a228e@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Aug 26, 2007 at 02:27:50PM +0400, Vitaly Bordug wrote:
> On Sat, 25 Aug 2007 11:49:58 +0200 Segher Boessenkool wrote:
[snip]
> > > +			compatible = "ibm, 440epx";
> > 
> > Stray space.  And you need to say it is the PCI host, so something
> > like "ibm,440epx-pci".
> > 
> OK, will have "amcc,.440epx-pci" here

Uh... now instead of a stray space you have a stray '.'

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
