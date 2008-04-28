Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5249CDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 07:54:31 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3SLsPRr009639
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 14:54:26 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3SLsPXB009757
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 16:54:25 -0500 (CDT)
Date: Mon, 28 Apr 2008 16:54:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sean MacLennan <seanm@seanm.ca>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080428215424.GA15973@ld0162-tx32.am.freescale.net>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428145310.553b8271@lappy.seanm.ca>
	<fa686aa40804281256y722d8cf6pcae462d68b04e01f@mail.gmail.com>
	<20080428173738.6b1a2896@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080428173738.6b1a2896@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 05:37:38PM -0400, Sean MacLennan wrote:
> > Why is this information in the dts *and* the platform file?  I haven't
> > been following the flash partition map binding conventions, but having
> > it in both places looks wrong....
> > 
> > oh, wait... the one in the dts is for NOR and this one is for NAND,
> > right?  And we don't have a binding yet for NAND partitions yet,
> > correct?
> 
> Correct.

Why can't the existing partition binding be used with NAND?  It's what we
do with Freescale FCM NAND.

-Scott
