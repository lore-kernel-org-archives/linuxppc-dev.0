Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9E97DDFF6
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 03:23:07 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3UHMsNV001145
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 10:22:55 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3UHMsnA006069
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 12:22:54 -0500 (CDT)
Date: Wed, 30 Apr 2008 12:22:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
Message-ID: <20080430172254.GA28169@ld0162-tx32.am.freescale.net>
References: <20071023212404.GA30942@loki.buserror.net>
	<Pine.LNX.4.64.0804251454050.6045@axis700.grange>
	<20080428203322.GD15223@ld0162-tx32.am.freescale.net>
	<18454.42926.213374.977098@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18454.42926.213374.977098@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 02:44:30PM +1000, Paul Mackerras wrote:
> 3. The style in all the assembly code is not to have spaces after
> commas separating instruction operands.

I'll do that if that's what is prefered, but how did that come about as
the style used?  It's different from what we do in C, and adding the
space helps readability in asm as well...

> The untested patch below is what I was thinking of.  If you'd like to
> try it out, I'd be interested to hear how it goes.

It works for me.

-Scott
