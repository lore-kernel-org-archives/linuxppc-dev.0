Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC934DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:53:06 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 11/12] powermac: disallow pmu sleep notifiers from
	aborting sleep
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124615.015873000@sipsolutions.net>
Date: Wed, 07 Feb 2007 23:52:50 +0100
In-Reply-To: <20070207124615.015873000@sipsolutions.net> (Johannes Berg's
	message of "Wed, 07 Feb 2007 13:45:47 +0100")
Message-ID: <jetzxxk2bh.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> Tracing through the code, no current PMU sleep notifier can abort sleep.
> Since no new PMU sleep notifiers should be added, this patch simplifies the
> code and removes the ability to abort sleep.

There is a use of PBOOK_SLEEP_OK left in
arch/powerpc/platforms/powermac/time.c.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
