Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BFA2CDE4A4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 04:29:59 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3LITsnO029554
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 11:29:55 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3LITrlt026460
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 13:29:54 -0500 (CDT)
Date: Mon, 21 Apr 2008 13:29:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [PPC] Remove mpc8272 ads board from arch/ppc
Message-ID: <20080421182953.GB6111@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
	<fa686aa40804191114i2cef26eegabfe9bc28d8ecc18@mail.gmail.com>
	<5422E8EE-4AFA-491B-8920-BDEBF596FF00@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5422E8EE-4AFA-491B-8920-BDEBF596FF00@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 10:25:09AM -0500, Kumar Gala wrote:
> 
> On Apr 19, 2008, at 1:14 PM, Grant Likely wrote:
> >On Sat, Apr 19, 2008 at 9:52 AM, Kumar Gala  
> ><galak@kernel.crashing.org> wrote:
> >>We have a board port in arch/powerpc so we dont need this one  
> >>anymore.
> >>
> >>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> >
> >Personally, I'd rather not do the piecemeal removal of board ports
> >from arch/ppc.  We've only got one release left anyway.  Removing them
> >just generates more churn and has the risk of causing other side
> >effects.
> 
> I can understand it, but I think removing them makes it obvious to  
> anyone that's lurking.  Call in maintainer prerogative :)

Speaking of making it obvious, is it time to put a #warning in some
prominent arch/ppc header?

-Scott
