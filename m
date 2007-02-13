Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 60F46DDF4A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 03:27:28 +1100 (EST)
Date: Tue, 13 Feb 2007 10:00:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 18/19] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070213160045.GB24815@ld0162-tx32.am.freescale.net>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230145.GR3849@ld0162-tx32.am.freescale.net>
	<20070209230700.GC12035@mag.az.mvista.com>
	<45D09993.9050903@freescale.com>
	<1171314615.4003.27.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171314615.4003.27.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2007 at 03:10:15PM -0600, Josh Boyer wrote:
> On Mon, 2007-02-12 at 10:45 -0600, Scott Wood wrote:
> > Mark A. Greer wrote:
> > > Is this necessary?  Shouldn't there always be a virtual-reg?
> > 
> > None of the dts files in the kernel tree currently have such a property...
> 
> 4xx will use this.  The bootwrapper will use the UART mapping setup by
> the firmware to print out to the console.  At least that is why it was
> added to being with, and how I had it working on Ebony a while ago.
> David may have changed it since.

Note that my patch will still use virtual-reg if it is there; the ranges
parsing is a fall back for the targets that don't need virtual-reg.

-Scott
