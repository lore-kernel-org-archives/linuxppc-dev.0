Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 999ED67A39
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 18:56:33 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Unwire set/get_robust_list
References: <jeodtvfn4x.fsf@sykes.suse.de>
	<1157409148.2473.209.camel@shinybook.infradead.org>
	<je8xkzfbx2.fsf@sykes.suse.de>
	<17671.15625.76850.349526@cargo.ozlabs.ibm.com>
Date: Wed, 13 Sep 2006 10:56:11 +0200
In-Reply-To: <17671.15625.76850.349526@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 13 Sep 2006 09:04:41 +1000")
Message-ID: <je3bawgn6c.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Andreas Schwab writes:
>
>> Thanks, sucessfully tested on 32bit (with the nptl testsuite of glibc).
>> Will do some 64bit testing tomorrow.
>
> Did you do that testing?  What was the result?

Yes, I did, successful.

> Could you test David's latest patch without the memory clobber?

I'll do.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
