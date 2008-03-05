Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5BBF4DDFE8
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 04:30:57 +1100 (EST)
Date: Wed, 5 Mar 2008 11:31:28 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] Emerson KSI8560 device tree
Message-ID: <20080305173128.GA12443@loki.buserror.net>
References: <20080304162322.GA19634@ru.mvista.com>
	<20080304163540.GD19634@ru.mvista.com>
	<20080304232940.GB8399@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304232940.GB8399@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 05, 2008 at 10:29:40AM +1100, David Gibson wrote:
> On Tue, Mar 04, 2008 at 07:35:40PM +0300, Alexandr Smirnov wrote:
> > +			device_type = "network";
> > +			model = "TSEC";
> > +			compatible = "gianfar";
> 
> This still looks like the old binding.

Unfortunately, only the mdio node has a new binding.  The gianfar driver
itself (or rather the glue code in fsl_soc.c) still insists on the above.

-Scott
