Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FCD4DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 01:47:13 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] powerpc: Do not fail build if mkimage is not available
References: <200712261453.41849.mb@bu3sch.de>
Date: Wed, 26 Dec 2007 15:47:05 +0100
In-Reply-To: <200712261453.41849.mb@bu3sch.de> (Michael Buesch's message of
	"Wed\, 26 Dec 2007 14\:53\:41 +0100")
Message-ID: <jed4st3446.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, paulus@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Buesch <mb@bu3sch.de> writes:

> +    if ! [ -x mkimage ]; then

What is this supposed to test?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
