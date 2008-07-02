Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88FA9DDF5E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:41:56 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m62FfouD024651
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 08:41:50 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m62FfnD2004690
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 10:41:49 -0500 (CDT)
Date: Wed, 2 Jul 2008 10:41:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: patches for 2.6.27...
Message-ID: <20080702154148.GA10375@ld0162-tx32.am.freescale.net>
References: <068935A1-11BE-4AEB-9C0E-E1AB53F1618E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <068935A1-11BE-4AEB-9C0E-E1AB53F1618E@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 02:56:16AM -0500, Kumar Gala wrote:
> Please point out any patches that have been posted but havent made it  
> into a git tree related to Freescale chips.
> 
> I know there are probably a slew of CPM patches that need to get into  
> the tree.

Could you apply the 83xx power management patchset (the gianfar bits had
been acked by Jeff long ago)?

-Scott
