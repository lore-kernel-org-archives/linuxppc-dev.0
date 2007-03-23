Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 14:28:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 4/10] Add arch/powerpc driver for UIC,
	PPC4xx interrupt controller
Message-ID: <20070323032858.GF28006@localhost.localdomain>
References: <20070322060630.GB16993@localhost.localdomain>
	<20070322092202.1299EDDF3E@ozlabs.org>
	<20070322095118.GA18236@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322095118.GA18236@moe.telargo.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 10:51:18AM +0100, Domen Puncer wrote:
> On 22/03/07 20:22 +1100, David Gibson wrote:
> > +static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)
> 
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		trigger = 0; polarity = 1;
> > +		break;
> > +	case IRQ_TYPE_LEVEL_LOW:
> > +		trigger = 0; polarity = 1;
> 
> Is this intended to be the same?

Oops, no.  Thanks for spotting that, the Ebony has no level-low
devices, so I didn't notice any problems.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
