Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9305D67CB1
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2005 04:12:06 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Frank van Maarseveen <frankvm@frankvm.com>
References: <20050715162741.GA23228@janus>
Date: Fri, 15 Jul 2005 20:11:57 +0200
In-Reply-To: <20050715162741.GA23228@janus> (Frank van Maarseveen's message of
	"Fri, 15 Jul 2005 18:27:41 +0200")
Message-ID: <je3bqg6is2.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: arch/ppc/kernel/misc.S: .align 5?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Frank van Maarseveen <frankvm@frankvm.com> writes:

> At least in 2.6.12.2 I see this in arch/ppc/kernel/misc.S:
>
> 	.text
>
> 	.align  5

.align == .p2align on ppc.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
