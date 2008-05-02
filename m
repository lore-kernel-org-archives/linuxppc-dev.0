Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7025DE034
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 01:12:39 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m42F7vdR004590
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 08:07:59 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m42F7rue021139
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 10:07:53 -0500 (CDT)
Date: Fri, 2 May 2008 10:07:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
Message-ID: <20080502150753.GA7753@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 02, 2008 at 09:21:08AM -0500, Kumar Gala wrote:
> GCC 4.4.x looks to be adding support for generating out-of-line register
> saves/restores based on:
> 
> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
> 
> This breaks the kernel build as we'd have to link with libgcc to get the
> implementation of the register save/restores.

<brokenrecord>
Why don't we just link with libgcc?
</brokenrecord>

-Scott
