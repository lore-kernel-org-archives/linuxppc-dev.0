Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80197DDE36
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 00:35:31 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop> <20071206063940.GA16474@kroah.com>
	<1196927934.7033.39.camel@pasglop>
	<20071206081628.GA15868@parisc-linux.org>
	<C608AAD4-29F7-4D5D-AA85-3B28CCCAADE5@kernel.crashing.org>
Date: Thu, 06 Dec 2007 14:35:25 +0100
In-Reply-To: <C608AAD4-29F7-4D5D-AA85-3B28CCCAADE5@kernel.crashing.org> (Kumar
	Gala's message of "Thu\, 6 Dec 2007 07\:24\:12 -0600")
Message-ID: <jetzmwosiq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Matthew Wilcox <matthew@wil.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> writes:

> How does gcc deal with glibc extension to allow people to add their  
> own specifiers?

It doesn't, gcc only knows about the standard specifiers.  But it also
defines attributes that check other formats, like its own asm_fprintf
format specs.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
