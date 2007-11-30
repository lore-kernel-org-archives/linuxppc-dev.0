Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 20443DDED5
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 02:12:08 +1100 (EST)
Date: Fri, 30 Nov 2007 09:12:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Add MPC837xEMDS PCIE RC mode support
Message-ID: <20071130151201.GA29484@loki.buserror.net>
References: <1196394334.29683.5.camel@Guyver>
	<20071130041404.GB26982@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071130041404.GB26982@lixom.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>, Li Li <r64360@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2007 at 10:14:04PM -0600, Olof Johansson wrote:
> On Fri, Nov 30, 2007 at 11:45:34AM +0800, Li Li wrote:
> > +	help
> > +	  Enables MPC837x PCI express RC mode
> 
> Why have a separate config option for this?

To save code size when it isn't needed?

> For systems where you don't want PCI-e configured, it should be left
> out of the device tree instead.

The dts should represent what exists on the hardware, not what you want to
use.

-Scott
