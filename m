Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54BFB67AA0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 01:49:20 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Collins <paul@briny.ondioline.org>
Subject: Re: PowerBook5,4 -- no sound?
References: <878xq51t61.fsf@briny.internal.ondioline.org>
Date: Sun, 16 Apr 2006 17:49:14 +0200
In-Reply-To: <878xq51t61.fsf@briny.internal.ondioline.org> (Paul Collins's
	message of "Mon, 17 Apr 2006 00:39:18 +1000")
Message-ID: <je1wvxo70l.fsf@sykes.suse.de>
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

Paul Collins <paul@briny.ondioline.org> writes:

> With Linus's current git plus the boot fix and some unrelated patches
> (console font and bluetooth) sound no longer seems to work (nothing in
> /proc/asound/cards), although snd-powermac loaded without complaint.
> Is this a known problem?

Sound doesn't work here on PowerMac7,3 either, it even oopses during
module loading.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
