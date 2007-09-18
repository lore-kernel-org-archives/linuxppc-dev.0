Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5802DDDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 00:22:02 +1000 (EST)
Date: Tue, 18 Sep 2007 09:21:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/28] CPM: Change from fsl,
	brg-frequency to brg/clock-frequency
Message-ID: <20070918142150.GA441@ld0162-tx32.am.freescale.net>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165728.GA6563@loki.buserror.net>
	<20070918061141.GE30766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070918061141.GE30766@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 04:11:41PM +1000, David Gibson wrote:
> > +	/* Legacy device binding -- will go away when no users are left. */
> > +	node = of_find_node_by_type(NULL, "cpm");
> > +	if (node) {
> > +		prop = of_get_property(node, "brg-frequency", &size);
> 
> Shouldn't you check for "fsl,brg-frequency" here, in case of old
> device trees?

What old device trees?  fsl,brg-frequency has never hit mainline; it's
only been in Kumar's tree for a week or so.

-Scott
