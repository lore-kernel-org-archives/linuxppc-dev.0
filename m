Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0BC65DE4B2
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 04:15:49 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3SIFiTq019705
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 11:15:44 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3SIFhgp003826
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 13:15:43 -0500 (CDT)
Date: Mon, 28 Apr 2008 13:15:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/7] mpc83xx: timer driver for PM wakeup
Message-ID: <20080428181543.GL9849@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
	<Pine.LNX.4.64.0804281721050.7897@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804281721050.7897@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 05:39:32PM +0200, Guennadi Liakhovetski wrote:
> This is a driver for the mpc83xx's GTM4 timer.  It's functionality
> is limited to providing a wakeup source for suspend-to-RAM.

This driver should be redone as a client of Anton's more general GTM
driver.

-Scott
