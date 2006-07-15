Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 645AF67B7E
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jul 2006 03:12:15 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 06/12] aoa: pmf gpio: report if function calling fails
References: <20060707165207.877010000@sipsolutions.net>
	<20060707165531.206137000@sipsolutions.net>
Date: Sat, 15 Jul 2006 19:12:05 +0200
In-Reply-To: <20060707165531.206137000@sipsolutions.net> (Johannes Berg's
	message of "Fri, 07 Jul 2006 18:52:13 +0200")
Message-ID: <jebqrqbxne.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> This patch makes the pmf GPIO layer in aoa report if calling
> a platform function failed.

This will always fire when a switch like lineout-mute does not exist,
apparently because layout_notify does not check for that.

pmf_gpio_set_lineout failed, rc: -19

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
