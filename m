Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 994A9DDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 21:35:34 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Appletouch going wild
References: <je640ba837.fsf@sykes.suse.de>
	<1194659997.7258.25.camel@johannes.berg>
Date: Sat, 10 Nov 2007 11:35:28 +0100
In-Reply-To: <1194659997.7258.25.camel@johannes.berg> (Johannes Berg's message
	of "Sat\, 10 Nov 2007 02\:59\:57 +0100")
Message-ID: <je7ikq9ymn.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2007-11-09 at 13:58 +0100, Andreas Schwab wrote:
>> Every once in a while the touchpad in my iBook G4 (geyser1, 030B) is
>> going wild, emitting random movement events even when not being touched.
>> That started only with 2.6.24-rc1.  The only way to stop it is to reload
>> the appletouch module.  My guess would be that reinitializing the
>> touchpad can result in some kind of race condition.
>
> Is it the same in -rc2?

Yes.

> The bad patch that broke fountains was fixed later, but you do have a
> geyser.

I don't see the messages you were seeing with your fountain, geyser1
does understand the geyser mode request, although it apparently uses raw
mode by default.  The reinit does help shutting up the stream of zero
moves, so it is not bad per se.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
