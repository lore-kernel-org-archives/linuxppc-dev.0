Return-Path: <schwab@suse.de>
Received: from Cantor.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6660667A67
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2005 21:35:51 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <jed5tuqlp1.fsf@sykes.suse.de> <1111377588.3835.258.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 21 Mar 2005 11:35:45 +0100
In-Reply-To: <1111377588.3835.258.camel@gaston> (Benjamin Herrenschmidt's
	message of "Mon, 21 Mar 2005 14:59:48 +1100")
Message-ID: <jey8che16m.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Wakeup broken on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> What video chip is this ?

Radeon Mobility M7 LY

> And what CPU ?

750FX

> Are you sure it's the radeonfb patch ?

It's hard to tell.  I tried going back to the 2.6.10 radeon driver, but
that doesn't have the necessary hooks to tell the PM code that it can
sleep.  If you can give a hint how to forward port that I can give it a
try.

> There is also an old problem with AGP and sleep that is coming & going
> lately. Can you check if it works if you never go to X ?

Did that, same problem.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
