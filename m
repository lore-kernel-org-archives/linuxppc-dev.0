Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Mar 2008 11:16:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] Emerson KSI8560 device tree
Message-ID: <20080306001612.GB16422@localhost.localdomain>
References: <20080304162322.GA19634@ru.mvista.com>
	<20080304163540.GD19634@ru.mvista.com>
	<20080304232940.GB8399@localhost.localdomain>
	<20080305173128.GA12443@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080305173128.GA12443@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 05, 2008 at 11:31:28AM -0600, Scott Wood wrote:
> On Wed, Mar 05, 2008 at 10:29:40AM +1100, David Gibson wrote:
> > On Tue, Mar 04, 2008 at 07:35:40PM +0300, Alexandr Smirnov wrote:
> > > +			device_type = "network";
> > > +			model = "TSEC";
> > > +			compatible = "gianfar";
> > 
> > This still looks like the old binding.
> 
> Unfortunately, only the mdio node has a new binding.  The gianfar driver
> itself (or rather the glue code in fsl_soc.c) still insists on the above.

Oh.  Yuck :(.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
