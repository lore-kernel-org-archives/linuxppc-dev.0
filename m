Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD0F5DDFA1
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 18:49:50 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull from 'for_paulus' branch
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
	<jelke2ss3n.fsf@sykes.suse.de>
	<18053.65260.136499.154352@cargo.ozlabs.ibm.com>
	<jeir95j21k.fsf@sykes.suse.de>
	<18054.4311.784767.549009@cargo.ozlabs.ibm.com>
Date: Sat, 30 Jun 2007 10:49:45 +0200
In-Reply-To: <18054.4311.784767.549009@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat\, 30 Jun 2007 18\:14\:15 +1000")
Message-ID: <jed4zdj07q.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Andreas Schwab writes:
>
>> Is your assembler older than 4 years?
>
> No, well, at least not unless Debian sid is seriously behind the
> times.  It's version 2.17 from the Debian binutils 2.17-3 package.

Probably some debian patches messed it up.  I'd suggest reporting that
to them.  FWIW, the unmodified assembler gives this error when operating
in 32bit mode:

$ echo 'sldi 0,0,10' | as
{standard input}: Assembler messages:
{standard input}:1: Error: Unrecognized opcode: `rldicr'

But just addding -many (which gcc always passes) will let the assembler
accept this.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
