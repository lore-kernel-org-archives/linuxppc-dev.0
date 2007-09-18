Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Sep 2007 09:48:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 01/28] CPM: Change from fsl,
	brg-frequency to brg/clock-frequency
Message-ID: <20070918234801.GA13386@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165728.GA6563@loki.buserror.net>
	<20070918061141.GE30766@localhost.localdomain>
	<20070918142150.GA441@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070918142150.GA441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 09:21:50AM -0500, Scott Wood wrote:
> On Tue, Sep 18, 2007 at 04:11:41PM +1000, David Gibson wrote:
> > > +	/* Legacy device binding -- will go away when no users are left. */
> > > +	node = of_find_node_by_type(NULL, "cpm");
> > > +	if (node) {
> > > +		prop = of_get_property(node, "brg-frequency", &size);
> > 
> > Shouldn't you check for "fsl,brg-frequency" here, in case of old
> > device trees?
> 
> What old device trees?  fsl,brg-frequency has never hit mainline; it's
> only been in Kumar's tree for a week or so.

Ah, ok.  I didn't realise.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
