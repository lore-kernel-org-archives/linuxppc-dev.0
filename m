Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FAADDE0BD
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 23:06:05 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: powerbook VT garbled between rc7 and rc8
References: <1229078554.3600.8.camel@johannes.berg>
Date: Fri, 12 Dec 2008 13:05:56 +0100
In-Reply-To: <1229078554.3600.8.camel@johannes.berg> (Johannes Berg's message
	of "Fri, 12 Dec 2008 11:42:34 +0100")
Message-ID: <je7i65r42j.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> After upgrading to -rc8 yesterday my powerbook started up today with the
> screen totally garbled, only occasionally was a word readable.

Try 6c34bc2976b30dc8b56392c020e25bae1f363cab (Revert "radeonfb:
accelerate imageblit and other improvements").

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
