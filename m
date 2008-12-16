Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98304DDF61
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 20:37:04 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [patch 1/1] hvc_console: escape magic sysrq key
References: <20081216091544.061115344@linux.vnet.ibm.com>
	<20081216092408.362722962@linux.vnet.ibm.com>
Date: Tue, 16 Dec 2008 10:36:55 +0100
In-Reply-To: <20081216092408.362722962@linux.vnet.ibm.com> (Hendrik
	Brueckner's message of "Tue, 16 Dec 2008 10:15:45 +0100")
Message-ID: <jeiqpkcvgo.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hendrik Brueckner <brueckner@linux.vnet.ibm.com> writes:

> +					/* if ^0 is pressed again, reset
> +					 * sysrq_pressed and flip ^0 char */

The comment says ^0 twice when ^O is meant.

> +					sysrq_pressed = (sysrq_pressed) ? 0 : 1;

                                        sysrq_pressed = !sysrc_pressed;

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
