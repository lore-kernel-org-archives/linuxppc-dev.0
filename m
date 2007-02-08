Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17866.41570.85932.301461@cargo.ozlabs.ibm.com>
Date: Thu, 8 Feb 2007 15:09:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Revised: [PATCH 5/11] Celleb: htab routines
In-Reply-To: <1170880786.2620.285.camel@localhost.localdomain>
References: <200702070845.l178jFjK001082@toshiba.co.jp>
	<1170880786.2620.285.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> On Wed, 2007-02-07 at 17:45 +0900, Ishizaki Kou wrote:
> 
> > +	local_irq_save(flags);
> > +	spin_lock(&beat_htab_lock);
> > +	dummy1 = beat_lpar_hpte_getword0(slot);
> > +
> 
> Sorry if I was not very clear... In that specific case, you can use
> spin_lock_irqsave(). The above works though, thus the patch can be
> merged, and we can do a cleanup patch on top later on to "fix it up"

I already merged the version of the patch that uses spin_lock_irqsave
and spin_unlock_irqrestore.  Please send a further patch on top of
that if anything needs to be changed.

Paul.
