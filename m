Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2D96DE0A6
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 07:33:20 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m82LXEH2029588
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 14:33:14 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m82LXD54022883
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 16:33:13 -0500 (CDT)
Date: Tue, 2 Sep 2008 16:33:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Initialization order
Message-ID: <20080902213312.GA18146@ld0162-tx32.am.freescale.net>
References: <48BDAFF3.2090803@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BDAFF3.2090803@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 02, 2008 at 03:28:19PM -0600, Gary Thomas wrote:
> I'm working with a couple FreeScale platforms and having
> trouble getting the RTC which is connected via I2C to work.
> I had this working fine in the old arch/ppc tree, but it's
> failing in the arch/powerpc world.

Make sure the rtc chip is described in the device tree (search existing
trees for rtc@ for examples).

> Here's the problem - the RTC driver gets initialized *before*
> the I2C bus

That's OK.

-Scott
