Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45FA5DE194
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:10:34 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n07MATcn012807
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 15:10:30 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n07MAS2q011371
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 16:10:28 -0600 (CST)
Date: Wed, 7 Jan 2009 16:10:28 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
Message-ID: <20090107221028.GA18669@ld0162-tx32.am.freescale.net>
References: <20090107135457.234150@gmx.net> <20090107140132.140980@gmx.net>
	<fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 09:41:14AM -0700, Grant Likely wrote:
> > +                       8042@60 {
> > +                               device_type = "8042";
> > +                               reg = <1 0x00000060 0x00000001
> > +                                      1 0x00000064 0x00000001>;
> > +                               // IRQ1, IRQ12 (rising edge)
> > +                               interrupts = <1 3 12 3>;
> 
> For the flattened device tree, I think we've settled on the convention
> that every node with an IRQ connection should have both the
> interrupt-parent and interrupts properties.  (ie. don't rely on the
> parent node's interrupt-parent property.)

Why?

-Scott
