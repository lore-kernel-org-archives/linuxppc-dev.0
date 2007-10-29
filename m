Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80DD8DE19B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 08:15:23 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Jan Dittmer <jdi@l4x.org>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten> <jesl3udm0e.fsf@sykes.suse.de>
	<4725F34C.6090904@ppp0.net> <jelk9mdj6e.fsf@sykes.suse.de>
	<47263830.2010009@l4x.org>
Date: Mon, 29 Oct 2007 22:15:15 +0100
In-Reply-To: <47263830.2010009@l4x.org> (Jan Dittmer's message of "Mon\, 29 Oct
	2007 20\:44\:48 +0100")
Message-ID: <jebqahei70.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Jan Dittmer <jdittmer@ppp0.net>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan Dittmer <jdi@l4x.org> writes:

> Andreas Schwab wrote:
>> Jan Dittmer <jdittmer@ppp0.net> writes:
>>
>>> $ powerpc64-linux-gcc-4.0.4 -v
>>> Using built-in specs.
>>> Target: powerpc64-linux
>>> Configured with: ../configure --prefix=/usr/cc217
>>> --exec-prefix=/usr/cc217/powerpc64 --target=powerpc64-linux
>>> --disable-shared --disable-werror --disable-nls --disable-threads
>>> --disable-werror --disable-libmudflap --with-newlib --with-gnu-as
>>> --with-gnu-ld --enable-languages=c
>>> Thread model: single
>>> gcc version 4.0.4
>>>
>>> g5_defconfig:
>>>
>>> $ make ARCH=powerpc HOSTCC=gcc-4.0 CROSS_COMPILE=powerpc64-linux- 
>>> CROSS32_COMPILE=powerpc64-linux-
>>
>> Your compiler still needs -m32 to generate 32-bit code (or use
>> --with-cpu=default32 to make that the default).
>
> 4.1.2 exhibits the same behavior.

What do you mean with "the same behavior"?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
