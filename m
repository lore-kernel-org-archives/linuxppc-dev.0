Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mx1.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C152267A64
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 09:20:51 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1112594783.26086.22.camel@gaston>
	<1112616384.19004.60.camel@gaston> <jezmwa6y4i.fsf@sykes.suse.de>
	<1112913519.9568.295.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 08 Apr 2005 01:20:45 +0200
In-Reply-To: <1112913519.9568.295.camel@gaston> (Benjamin Herrenschmidt's
	message of "Fri, 08 Apr 2005 08:38:38 +1000")
Message-ID: <jer7hm6unm.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: iBook G3 owners
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> I know, but this oneliner is incorrect. It can't be correct, no way.
> That is very strange, and that's what I'm trying to figure out. Can you
> try instead changing the start address of the flush from 0xfff00000 to 0
> by changing the L1 flush bit initalisation from lis r4,0xfff0 to li
> r4,0 ?

This fixes the problem.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
