Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7383BDDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 08:43:55 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m8OMhnUx018093
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 15:43:49 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m8OMhmO9006536
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 17:43:48 -0500 (CDT)
Date: Wed, 24 Sep 2008 17:43:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: Please pull from 'for-2.6.27'
Message-ID: <20080924224347.GA29132@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>
	<18BF734B-F71B-4FDD-B3C9-62AA5EB54283@kernel.crashing.org>
	<18639.61790.750450.103022@cargo.ozlabs.ibm.com>
	<48D0DC23.9070902@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48D0DC23.9070902@scram.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 17, 2008 at 12:29:55PM +0200, Jochen Friedrich wrote:
> > It doesn't even tell me why not being thread-safe is a problem on a
> > UP machine.

Preemption.

> This isn't a regression since the stuff is new in 2.6.27. IMHO this can
> wait until 2.6.28.

It would be a bug in 2.6.27 that did not exist in 2.6.26...  is there
anything that used to use another mechanism that now uses this?

That's not to say that it's necessarily critical enough this late in the
process, but in general I'm not very comfortable with not being able to
fix newly added code as soon as the merge window closes because it's not
a "regression".

-Scott
