Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87E32DDEF2
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 01:20:11 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m42FK2LW012235
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 08:20:02 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m42FK1iO021682
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 10:20:02 -0500 (CDT)
Date: Fri, 2 May 2008 10:20:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Message-ID: <20080502152001.GB7753@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
	<BC3385F6-8403-446C-BC04-4DA811CFE96A@kernel.crashing.org>
	<20862df61b024849f55dbd54de7cfb8f@kernel.crashing.org>
	<68FE3962-84B3-4A5A-A64A-3FD1B7F6B4E3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68FE3962-84B3-4A5A-A64A-3FD1B7F6B4E3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 02, 2008 at 08:41:27AM -0500, Kumar Gala wrote:
> I assume there is a reason we don't link libgcc w/the kernel.

Inertia?

BTW, it looks like ARM, SuperH, PA-Risc, and a few others do link in
libgcc.

-Scott
