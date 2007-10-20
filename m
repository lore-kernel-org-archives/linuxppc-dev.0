Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A990DDDEB6
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 18:51:35 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 3/4] DTC: Appease the printf() format $Gods with a correct
	type.
References: <E1IivsP-00078Q-Hf@jdl.com>
	<20071020071920.GF26642@localhost.localdomain>
Date: Sat, 20 Oct 2007 10:51:29 +0200
In-Reply-To: <20071020071920.GF26642@localhost.localdomain> (David Gibson's
	message of "Sat\, 20 Oct 2007 17\:19\:20 +1000")
Message-ID: <jesl46yxri.fsf@sykes.suse.de>
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

David Gibson <david@gibson.dropbear.id.au> writes:

> What compiler/platform is this?  I can't off the top of my head think
> of one where size_t shouldn't be promoted to int automatically.

Only types narrower than int are subject to integer promotion.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
