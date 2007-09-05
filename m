Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09C31DDFCA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 07:59:02 +1000 (EST)
Date: Wed, 5 Sep 2007 16:58:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/3] CPM: Change from fsl,
	brg-frequency to brg/clock-frequency
Message-ID: <20070905215851.GA7965@ld0162-tx32.am.freescale.net>
References: <20070905191313.GA31927@ld0162-tx32.am.freescale.net>
	<20070905215708.GA8718@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905215708.GA8718@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 04:57:08PM -0500, Olof Johansson wrote:
> On Wed, Sep 05, 2007 at 02:13:13PM -0500, Scott Wood wrote:
> > As suggested by David Gibson, now that we have a separate node
> > for the baud rate generators, it's better to use the standard
> > clock-frequency property than a cpm-node-level fsl,brg-frequency
> > property.
> > 
> > This patch updates existing places where fsl,brg-frequency is
> > used.
> 
> What about older platforms that were booted with the older device
> tree? Don't you have to stay compatible with them?

The older platforms use /soc/cpm/brg-frequency, not
/soc/cpm/fsl,brg-frequency -- and that is still supported.  The latter
only exists as one patch in Kumar's tree.

-Scott
