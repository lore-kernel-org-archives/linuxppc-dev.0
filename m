Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67E14DE0C3
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 19:31:08 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch] use __attribute__ in asm-powerpc
References: <200707142336.10343.vapier@gentoo.org>
	<Pine.LNX.4.62.0707161117150.1072@pademelon.sonytel.be>
Date: Mon, 16 Jul 2007 11:30:57 +0200
In-Reply-To: <Pine.LNX.4.62.0707161117150.1072@pademelon.sonytel.be> (Geert
	Uytterhoeven's message of "Mon\, 16 Jul 2007 11\:18\:36 +0200 \(CEST\)")
Message-ID: <jetzs4bsq6.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Mike Frysinger <vapier@gentoo.org>,
	linux-kernel@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> writes:

> If the code is not exported to userspace (and thus not subject to different
> compilers), I think the preferred form is plain `attribute'.

That does not exist without underscores.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
