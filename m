Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 6A151B6F62
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 08:32:38 +1000 (EST)
Date: Tue, 28 Jun 2011 17:31:31 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4]PPC4xx: Adding PCI(E) MSI support
Message-ID: <20110628223131.GA10267@crust.elkhashab.com>
References: <201103300910.p2U9AO8t024353@amcc.com>
	<1306387484.7481.453.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306387484.7481.453.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	rsarmah@apm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 26, 2011 at 03:24:44PM +1000, Benjamin Herrenschmidt wrote:
> 
> Please check the result and send any "fixup" patch that might be
> necessary.
> 
> > +static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
> > +				 struct resource res, struct ppc4xx_msi *msi)
> > +{
> > +

<snip>

> > +
> > +	msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> > +	if (msi->msi_dev)
> > +		return -ENODEV;

This does not look correct. I guess it should probably read 

if (!msi->msi_dev) .....

Ayman
