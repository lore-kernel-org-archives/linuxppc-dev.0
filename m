Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A1B9DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:07:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3UL7kse004547
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 14:07:46 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3UL7jn7016140
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 16:07:46 -0500 (CDT)
Date: Wed, 30 Apr 2008 16:07:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
Message-ID: <20080430210745.GA10569@ld0162-tx32.am.freescale.net>
References: <20071023212404.GA30942@loki.buserror.net>
	<Pine.LNX.4.64.0804251454050.6045@axis700.grange>
	<20080428203322.GD15223@ld0162-tx32.am.freescale.net>
	<18454.42926.213374.977098@cargo.ozlabs.ibm.com>
	<20080430172254.GA28169@ld0162-tx32.am.freescale.net>
	<2af4cf23ed3fc48c87b50a5f63d868d7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2af4cf23ed3fc48c87b50a5f63d868d7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 11:01:47PM +0200, Segher Boessenkool wrote:
> >>3. The style in all the assembly code is not to have spaces after
> >>commas separating instruction operands.
> >
> >I'll do that if that's what is prefered, but how did that come about as
> >the style used?  It's different from what we do in C,
> 
> But this isn't C code, it's assembler code.

Enh.  It's a comma-delineated list in both cases.

> PowerPC assembler code (and most other assembler code) doesn't use
> spaces here usually.

Looking at other arches, it seems pretty evenly split.

> >and adding the space helps readability in asm as well...
> 
> Many people disagree ;-)

Compressionhelpsreadability?

> Anyway, it's better to keep a consistent style, whatever that style
> is, don't you agree?

Not if it's GNU-style. :-)

-Scott
