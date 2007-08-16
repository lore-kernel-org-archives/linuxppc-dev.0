Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 197A2DDEEA
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 02:40:34 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Invalid semicolon after if statement
References: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
	<1187251702.8375.43.camel@concordia.ozlabs.ibm.com>
	<fa88c3e5b4b0f896a16688a525bcd744@kernel.crashing.org>
Date: Thu, 16 Aug 2007 18:40:27 +0200
In-Reply-To: <fa88c3e5b4b0f896a16688a525bcd744@kernel.crashing.org> (Segher
	Boessenkool's message of "Thu\, 16 Aug 2007 16\:03\:29 +0200")
Message-ID: <je7inva0w4.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:

>> Thanks to the frickin compiler for warning us, not.
>
> 4.3: "warning: suggest braces around empty body in an 'if' statement"
>
> 4.1: "warning: empty body in an if-statement"
>
> Your GCC is too old :-)

This warning is only enabled by -Wextra.  Only 4.3 has a separate option
for it (-Wempty-body).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
