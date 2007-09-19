Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 47EF8DDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:01:44 +1000 (EST)
Date: Wed, 19 Sep 2007 10:01:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: cuImage generation
Message-ID: <20070919150134.GA8249@ld0162-tx32.am.freescale.net>
References: <20070919072831.322800@gmx.net>
	<20070919141953.GB8023@ld0162-tx32.am.freescale.net>
	<87ps0elnad.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ps0elnad.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 04:53:14PM +0200, Peter Korsgaard wrote:
> How is it supposed to work now cuImage no longer is in BOOT_TARGETS?
> What make target are you supposed to work. It works if I add
> cuImage.83xx to BOOT_TARGETS and call make cuImage.83xx, but that can
> hardly be the correct way?

Ah, OK -- you need to type make zImage, not make uImage.

-Scott
