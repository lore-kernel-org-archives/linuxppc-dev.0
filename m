Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2534167A42
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 22:33:14 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [snd] looking for layout-ids
References: <1148553785.11759.12.camel@johannes.berg>
Date: Thu, 25 May 2006 14:33:03 +0200
In-Reply-To: <1148553785.11759.12.camel@johannes.berg> (Johannes Berg's
	message of "Thu, 25 May 2006 12:43:05 +0200")
Message-ID: <jefyiy9tds.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> In order to replace snd-powermac for the newer machines where the
> 'sound' node has the 'layout-id' property, I'm looking for testers on
> machines that have a layout-id [1] property with one of the following
> values: 0x24

That would be mine, but it has the problem of the broken device tree, so
i2sbus doesn't work yet.

> [2] Before you ask: I will not do this before snd-aoa supports headphone
> detection :)

Another important feature would be DRC, IMHO.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
