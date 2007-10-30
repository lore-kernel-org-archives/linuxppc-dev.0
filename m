Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E10BDE202
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 20:20:21 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Jan Dittmer <jdi@l4x.org>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten> <jesl3udm0e.fsf@sykes.suse.de>
	<4725F34C.6090904@ppp0.net> <jelk9mdj6e.fsf@sykes.suse.de>
	<47263830.2010009@l4x.org> <jebqahei70.fsf@sykes.suse.de>
	<47265586.1050701@l4x.org> <je640pebqn.fsf@sykes.suse.de>
	<4726DD82.8050200@l4x.org>
Date: Tue, 30 Oct 2007 10:20:15 +0100
In-Reply-To: <4726DD82.8050200@l4x.org> (Jan Dittmer's message of "Tue\, 30 Oct
	2007 08\:30\:10 +0100")
Message-ID: <jey7dlez74.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan Dittmer <jdi@l4x.org> writes:

> Your mail from 2007-10-29 4:39 pm (CET)
>
>>> Your compiler still needs -m32 to generate 32-bit code (or use
>>> --with-cpu=default32 to make that the default).
>
> See the 'still' ?

How would the compiler know whether to generate 64bit or 32bit code??

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
