Return-Path: <schwab@suse.de>
Received: from mail.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F392E67A79
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2005 07:56:38 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <jed5tuqlp1.fsf@sykes.suse.de> <1111377588.3835.258.camel@gaston>
	<jey8che16m.fsf@sykes.suse.de> <1111407779.1236.272.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 21 Mar 2005 21:56:22 +0100
In-Reply-To: <1111407779.1236.272.camel@gaston> (Benjamin Herrenschmidt's
	message of "Mon, 21 Mar 2005 23:22:58 +1100")
Message-ID: <je8y4g7m6h.fsf@sykes.suse.de>
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

> Can you try playing with pmac_sleep.S and pmac_cache.S, basically
> reverting those including the calls to set_L2CR in via-pmu.c ?

That makes it even worse (it apparently crashes almost immediately after
wakeup).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
