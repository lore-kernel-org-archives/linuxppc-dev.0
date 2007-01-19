Return-Path: <livio@eecg.toronto.edu>
Received: from picton.eecg.toronto.edu (picton.eecg.toronto.edu
	[128.100.10.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "picton.eecg.toronto.edu",
	Issuer "picton.eecg.toronto.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 82E5BDDDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 12:06:21 +1100 (EST)
Date: Thu, 18 Jan 2007 20:06:05 -0500
From: Livio Soares <livio@eecg.toronto.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][PowerPC] Remove ineffective CONFIG_IRQ_ALL_CPUS option
Message-ID: <20070119010605.GA3259@eecg.toronto.edu>
References: <20070117230255.GA31478@eecg.toronto.edu>
	<1169079378.4965.3.camel@localhost.localdomain>
	<20070118182152.GA11204@eecg.toronto.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070118182152.GA11204@eecg.toronto.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  Sorry to reply to myself, but...

Livio Soares writes:
>   Hello Ben,
> 
> Benjamin Herrenschmidt writes:
> > On Wed, 2007-01-17 at 18:02 -0500, Livio Soares wrote:
> 
> [...]

>   On  a side  note, I  probably need  to make  IRQ distribution  configurable at
> run-time (for  my personal work).  I  was thinking of exporting  a bit-mask type
> structure  through sysfs,  to enable  run-time configuration  of CPUs  which can
> receive interrupts (and possibly priorities). Would people be interested in such
> a patch?

  Looking at  the code, I found out  that this is _already_  being done; through
setting  affinities  of  interrupts.  If  you  can  get  the  bitmask  right  in
/proc/irq/[IRQ#]/smp_affinity,  you can  change the  distribution  of interrupts
(furthermore,  potentially  disable a  particular  IRQ  altogether a  particular
CPU). 

  Sorry for the noise,

			Livio
