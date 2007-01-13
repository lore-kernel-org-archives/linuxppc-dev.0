Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FD78DDE0E
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 00:20:25 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: yuraxa <ygeorgie@gmail.com>
Subject: Re: ppc inline asm syntax
References: <7cc53cfa0701130341x2dfdc8f1s9cb70ffa741fafb6@mail.gmail.com>
Date: Sat, 13 Jan 2007 14:20:20 +0100
In-Reply-To: <7cc53cfa0701130341x2dfdc8f1s9cb70ffa741fafb6@mail.gmail.com>
	(yuraxa's message of "Sat, 13 Jan 2007 12:41:39 +0100")
Message-ID: <je64bb6p2j.fsf@sykes.suse.de>
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

yuraxa <ygeorgie@gmail.com> writes:

> Hi, i'm writing some inline assembly for ppc.
> Grepping linux src code for examples i found syntax that i can't
> understand, but as i can see it's frequently used.

There is some documentation in the GCC internals manual, see
<http://gcc.gnu.org/onlinedocs/gccint/Output-Template.html>.  The ppc
specific operand modifiers are only documented in the GCC source, see
print_operand in
<http://gcc.gnu.org/viewcvs/trunk/gcc/config/rs6000/rs6000.c?view=markup>.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
