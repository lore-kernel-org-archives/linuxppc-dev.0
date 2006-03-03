Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53BEF67A06
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 01:39:15 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id C1569EBAC
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 15:39:10 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Olaf Hering <olh@suse.de>
Subject: Re: alignment bugs in prom_init
References: <20060303135717.GA5707@suse.de>
Date: Fri, 03 Mar 2006 15:39:10 +0100
In-Reply-To: <20060303135717.GA5707@suse.de> (Olaf Hering's message of "Fri, 3
	Mar 2006 14:57:17 +0100")
Message-ID: <jefylz1tkh.fsf@sykes.suse.de>
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

Olaf Hering <olh@suse.de> writes:

> sp is 0x0023e784, val is at offset 120, which makes 0x0023e7fc. This
> address is casted to u32, which changes it to 0x0023e7f8.

Since when does casting to u32 cut off the low bits?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
