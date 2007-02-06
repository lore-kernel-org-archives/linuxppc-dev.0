Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17863.52596.791276.129355@cargo.ozlabs.ibm.com>
Date: Tue, 6 Feb 2007 11:36:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH] Missing include in include/asm-powerpc/prom.h
In-Reply-To: <20070205205636.GA14589@Krystal>
References: <20070205142905.GA31392@Krystal>
	<1170706469.2620.124.camel@localhost.localdomain>
	<20070205205636.GA14589@Krystal>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mathieu Desnoyers writes:

> * Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> > On Mon, 2007-02-05 at 09:29 -0500, Mathieu Desnoyers wrote:
> > > Missing include in include/asm-powerpc/prom.h
> > > 
> > > include/asm-powerpc/prom.h needs to include asm/irq.h because it uses
> > > irq_of_parse_and_map and NO_IRQ. It applies on 2.6.20.
> > 
> > I'd rather not do that.... better to move of_irq_to_resource() to
> > prom_parse.c 
> > 
> 
> Thanks, this patch should apply on top of the previous patch in this thread.

Do you actually want this patch to go upstream?  Because if you do,
that really doesn't cut it as a patch description.  Please look at
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and resubmit
as one patch with an informative description.

Thanks,
Paul.
