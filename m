Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mx1.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 72B9667A33
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:02:13 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1112681154.9517.7.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 07 Apr 2005 01:02:04 +0200
In-Reply-To: <1112681154.9517.7.camel@gaston> (Benjamin Herrenschmidt's
	message of "Tue, 05 Apr 2005 16:05:54 +1000")
Message-ID: <jek6nf1pcj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Update ppc32-fix-errata-for-some-g3-cpus.patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> The previous version of ppc32-fix-errata-for-some-g3-cpus.patch had an
> issue that would crash some G4 CPUs on boot. This is fixed in this new
> version, please replace the old one and send to linus asap (it's now
> been tested on enough CPUs).

Apparently not.  I'm getting "floating point used in kernel" crashes
during wakeup on my iBook G3 (750FX).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
