Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53BDB689AD
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 10:22:30 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Olaf Hering <olh@suse.de>
References: <200601091916.k09JGMJY004116@hera.kernel.org>
	<20060110221313.GA24246@suse.de>
Date: Wed, 11 Jan 2006 00:22:25 +0100
In-Reply-To: <20060110221313.GA24246@suse.de> (Olaf Hering's message of "Tue,
	10 Jan 2006 23:13:14 +0100")
Message-ID: <jed5izmzwu.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, arndb@de.ibm.com
Subject: Re: [PATCH] powerpc: fix large nvram access
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering <olh@suse.de> writes:

> this change breaks my nvsetenv binary on JS20.
>
> (none):/# mount proc ; nvsetenv
> Error reading /dev/nvram: Success

It was broken to begin with.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
