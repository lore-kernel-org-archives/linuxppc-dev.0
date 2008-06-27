Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABA50DDDFB
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 04:04:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5RI4OIq001888
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 11:04:24 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m5RI4NHw023998
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 13:04:23 -0500 (CDT)
Date: Fri, 27 Jun 2008 13:04:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add 83xx and 86xx to 6xx Multiplatform
Message-ID: <20080627180423.GB12627@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0806271136240.20344@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0806271136240.20344@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 27, 2008 at 11:36:36AM -0500, Kumar Gala wrote:
> There isn't any reason at this point that we can't build 83xx & 86xx support
> in with the other 6xx based boards.  Twiddle the Kconfigs to allow this.

Likewise with 82xx -- why don't we just get rid of the "Machine type"
choice, and turn them all into bools?

At the very least, change the misleading prompt and help text of
PPC_MULTIPLATFORM before expanding the set of platforms that hide behind
it.

-Scott
