Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id E5987DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 20:30:46 +1000 (EST)
Date: Tue, 6 May 2008 11:30:55 +0100
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Add support for Analogue & Micro ASP837E board
Message-ID: <20080506113055.499947e5@neuromancer.mindspace>
In-Reply-To: <20080506161110.02c2f974.sfr@canb.auug.org.au>
References: <20080506032813.19e2d07a@neuromancer.mindspace>
	<20080506161110.02c2f974.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 May 2008 16:11:10 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Bryan,
> 
> On Tue, 6 May 2008 03:28:13 +0100 Bryan O'Donoghue <bodonoghue@codehermit.ie>
> wrote:
> >
> > +static void __init asp834x_init_IRQ(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_node_by_type(NULL, "ipic");
> > +	if (!np)
> > +		return;
> > +
> > +	ipic_init(np, 0);
> 
> You need an "of_node_put(np)" here to drop the reference gained in
> "of_find_node_by_type".
> 
> > +static struct of_device_id asp8347_ids[] = {
> 
> Please make this __initdata.
> 

Hey Stephen.

Thanks for spotting that. Will do.


Cheers,
Bryan
