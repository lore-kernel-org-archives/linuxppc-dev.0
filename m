Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FB40DE06D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 11:06:42 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3M16bvU011679
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:06:37 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3M16aHS014640
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 20:06:36 -0500 (CDT)
Date: Mon, 21 Apr 2008 20:06:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [PPC] Remove mpc8272 ads board from arch/ppc
Message-ID: <20080422010634.GA9245@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
	<fa686aa40804191114i2cef26eegabfe9bc28d8ecc18@mail.gmail.com>
	<5422E8EE-4AFA-491B-8920-BDEBF596FF00@kernel.crashing.org>
	<20080421182953.GB6111@ld0162-tx32.am.freescale.net>
	<00248a3c226d44aa352ebb69894183f4@kernel.crashing.org>
	<fa686aa40804211416l5a366f3dl3d91acbea00b539f@mail.gmail.com>
	<d6a1e8455b5c2c2a23d3713ee7c16805@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d6a1e8455b5c2c2a23d3713ee7c16805@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 11:25:29PM +0200, Segher Boessenkool wrote:
> >> The last time arch/ppc built for me (a few days ago), it got
> >> 535 warnings.

Heh.

> >> I don't think anyone would notice one more. 

Well, it wouldn't be one more, it'd be one per file that includes the
header.  If we choose something like asm/system.h, and scream in 
*** ALL CAPS!!one!11! ***, it should get through the noise.

> >> Also, whoever doesn't yet know arch/ppc will be going away has been
> >> living under a rock for the last two years.
> >
> >You say that as if it is an uncommon living condition.
> 
> Oh sorry.  "Under a rock without any connection to the intertubes".

I guess you missed the recent patch someone posted with style cleanup in
arch/ppc/8xx_io? :-P

-Scott
