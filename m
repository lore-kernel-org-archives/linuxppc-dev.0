Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 456D867BA3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 09:30:06 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Unwire set/get_robust_list
References: <jeodtvfn4x.fsf@sykes.suse.de>
	<1157409148.2473.209.camel@shinybook.infradead.org>
Date: Tue, 05 Sep 2006 01:29:45 +0200
In-Reply-To: <1157409148.2473.209.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Mon, 04 Sep 2006 15:32:27 -0700")
Message-ID: <je8xkzfbx2.fsf@sykes.suse.de>
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

David Woodhouse <dwmw2@infradead.org> writes:

> On Mon, 2006-09-04 at 21:27 +0200, Andreas Schwab wrote:
>> The syscalls set/get_robust_list must not be wired up until
>> futex_atomic_cmpxchg_inatomic is implemented.  Otherwise the kernel will
>> hang in handle_futex_death.
>
> Something like this? 
>
> Untested-but-otherwise-Signed-off-by: David Woodhouse <dwmw2@infradead.org>

Thanks, sucessfully tested on 32bit (with the nptl testsuite of glibc).
Will do some 64bit testing tomorrow.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
