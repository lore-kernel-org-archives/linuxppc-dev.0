Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2ED3DE011
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 07:15:13 +1000 (EST)
Date: Mon, 21 Jul 2008 16:13:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: Mikrotik RouterBoard 333
Message-ID: <20080721211344.GA13268@loki.buserror.net>
References: <20080708042631.GB7328@yookeroo.seuss>
	<20080709040925.GA13810@secretlab.ca> <487AA17E.6000808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <487AA17E.6000808@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 13, 2008 at 08:44:46PM -0400, Jerry Van Baren wrote:
> I'm a half-ack.  ;-)  I'm partial to u-boot's implementation rather than  
> using a bootwrapper for obvious reasons.  The u-boot implementation  
> takes the blob as a boot parameter and passes it along to the kernel  
> after doing appropriate (optional) fixups.

And if those fixups expect a malformed device tree?

> Other than that quibble, I agree that burning the blob into the firmware  
> so that the firmware must be recompiled and reburned to change the blob  
> is very undesirable.

I thought the device tree was *supposed* to be an interface between the
firmware and the kernel?  What if the firmware produces the tree
dynamically?  What if the firmware itself depends on having the device tree
in order to operate?

-Scott
