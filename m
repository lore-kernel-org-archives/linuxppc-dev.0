Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9DB98DDE3D
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 00:56:22 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5MEuG0S011143
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 07:56:16 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5MEuFuZ002345
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 09:56:15 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l5MEWb9g028995
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 09:32:37 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 17548AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 09:56:14 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l5MEuDrP019829
	for linuxppc-dev@ozlabs.org; Fri, 22 Jun 2007 09:56:13 -0500
Date: Fri, 22 Jun 2007 09:56:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Split out asm-ppc/mmu.h portions for PowerPC 8xx
Message-ID: <20070622145613.GA14543@ld0162-tx32.am.freescale.net>
References: <20070622045855.GA11775@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070622045855.GA11775@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 22, 2007 at 02:58:55PM +1000, David Gibson wrote:
> arch/powerpc still relies on asm-ppc/mmu.h for some 32-bit MMU types.
> This patch is another step towards fixing this.  It takes the portions
> of asm-ppc/mmu.h related to 8xx embedded CPUs which are still relevant
> in arch/powerpc and puts them in a new asm-powerpc/mmu-8xx.h,
> included when appropriate from asm-powerpc/mmu.h.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> 
> This applies on top of my earlier patch splitting out the Freescale
> Book-E portions of mmu.h.  I've compiled this (with
> mpc866_ads_defconfig) but can someone with access to an 8xx system
> give it a whirl?

I tested it on an 885 board; it seems fine.

-Scott
