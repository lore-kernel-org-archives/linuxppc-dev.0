Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35DD1DDEF3
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 03:09:14 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] powerpc: Do not fail build if mkimage is not available
References: <200712261453.41849.mb@bu3sch.de>
	<200712261635.43188.mb@bu3sch.de> <je4pe530vq.fsf@sykes.suse.de>
	<200712261701.33669.mb@bu3sch.de>
Date: Wed, 26 Dec 2007 17:08:55 +0100
In-Reply-To: <200712261701.33669.mb@bu3sch.de> (Michael Buesch's message of
	"Wed\, 26 Dec 2007 17\:01\:33 +0100")
Message-ID: <jeve6l1lrc.fsf@sykes.suse.de>
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

> I tested this and it obviously works very well for me.

Obviously your tests were incomplete.

> I even posted it for review on this list and nobody complained,
> including you.

???  I did point out an error in your patch just now.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
