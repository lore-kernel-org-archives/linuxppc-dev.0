Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D33D9DDF30
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:47:28 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<jeiqx83ab0.fsf@sykes.suse.de>
	<Pine.LNX.4.64.0805201502000.7453@t2.domain.actdsltmp>
Date: Wed, 21 May 2008 00:47:23 +0200
In-Reply-To: <Pine.LNX.4.64.0805201502000.7453@t2.domain.actdsltmp> (Trent
	Piepho's message of "Tue, 20 May 2008 15:11:02 -0700 (PDT)")
Message-ID: <jeabik385g.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho <tpiepho@freescale.com> writes:

> It's the _le versions that have a problem, since we can't get gcc to just use
> the register indexed mode.  It seems like an obvious thing to have a
> constraint for, but I guess there weren't enough instructions that only come
> in 'x' versions to bother with it.  There is a 'Z' constraint, "Memory operand
> that is an indexed or indirect from a register", but I tried it and it can use
> both "rb,ri" and "disp(rb)" forms.  Actually, I'm not sure how 'Z' is any
> different than "m"?

'Z' will never emit a non-zero constant displacement.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
