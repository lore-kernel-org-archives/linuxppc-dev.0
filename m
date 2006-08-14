Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0C4D67BCF
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 18:46:41 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] no-execute -- please test
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<17631.62940.63888.908937@cargo.ozlabs.ibm.com>
Date: Mon, 14 Aug 2006 10:46:32 +0200
In-Reply-To: <17631.62940.63888.908937@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Mon, 14 Aug 2006 14:02:36 +1000")
Message-ID: <jehd0fso0n.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Albert Cahalan <acahalan@gmail.com>, linuxppc-dev@ozlabs.org,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Albert Cahalan writes:
>
>> If you want heap protection, change VM_DATA_DEFAULT_FLAGS32
>> in include/asm-powerpc/page.h to be like VM_STACK_DEFAULT_FLAGS.
>> I'd love to hear if anybody can get X to start with this change.
>
> In general I would expect dynamically-linked programs to fail unless
> you compile everything with gcc -msecure-plt.

X (before X.org 7) does it's own module loading that cannot cope with a
non-executable heap.  X.org 7, on the other hand, uses dlopen now and
should work fine.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
