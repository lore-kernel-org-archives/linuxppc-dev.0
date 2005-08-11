Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA9DE67E9B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2005 02:14:51 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: "Rune Torgersen" <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859421@ismail.innsys.innovsys.com>
Date: Thu, 11 Aug 2005 18:14:40 +0200
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859421@ismail.innsys.innovsys.com>
	(Rune Torgersen's message of "Thu, 11 Aug 2005 10:13:23 -0500")
Message-ID: <jezmro30y7.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: CLOCK_TICK_RATE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Rune Torgersen" <runet@innovsys.com> writes:

> Hi
>
> I have found that I need to set CLOCK_TICK_RATE (currently defined in
> include/asm-ppc/timex.h) to something else.

I can't find any use of CLOCK_TICK_RATE in the kernel that is relevant for
ppc.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
