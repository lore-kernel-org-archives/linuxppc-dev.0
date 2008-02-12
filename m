Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C80F1DDF8A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 05:52:42 +1100 (EST)
Date: Tue, 12 Feb 2008 12:52:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080212185251.GB4042@loki.buserror.net>
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
	<20080211235958.GD18348@localhost.localdomain>
	<47B0F142.40206@pikatech.com>
	<20080212002030.GE18348@localhost.localdomain>
	<47B0EB23.9040101@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B0EB23.9040101@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2008 at 07:41:07PM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> > Err.. now I'm doubly confused.  Initially I thought you'd need to
> > change the size part of reg somewhere, but your description above just
> > convinced me you didn't (because you were essentially just shifting a
> > 4M map up into the high rather than low 4M of the 64M space).  Now
> > you're saying you do..
> >   
> If you tell the mtd driver that the flash is 64M, when it is really 4M, 
> it goes oops. So you do have to get the size right in the reg field.

It'd be nice if we could pass in a flag to tell it not to try to find
additional consecutive chips in the mapping...  It's a shame to have
probable chips, and still have to know how big they are anyway.

-Scott
