Return-Path: <schwab@suse.de>
Received: from Cantor.suse.de (mail-ex.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6841167A7C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 11:43:15 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1106011958.4533.25.camel@gaston> <je7jmaurl0.fsf@sykes.suse.de>
	<1106100264.4534.135.camel@gaston> <jemzv584yw.fsf@sykes.suse.de>
	<1106175427.5326.21.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 20 Jan 2005 01:43:07 +0100
In-Reply-To: <1106175427.5326.21.camel@gaston> (Benjamin Herrenschmidt's
	message of "Thu, 20 Jan 2005 09:57:07 +1100")
Message-ID: <jehdld7wx0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Even when building xmon into the kernel ?

Doh!  I didn't think of that.  This is what I get from xmon:

    <2>kernel BUG in unlock_page at mm/filemap.c:430!
    vector: 700 at pc = c003f098, lr = c0041654
    msr = 29032, sp = e71b1c80 [e71b1bd0]
    current = e7bbec70, pid = 2915, comm = syslogd

c0041654 = generic_file_buffered_write

Last kernel messages:

    radeonfb: switching to D0 state...
    HID1, after: 70000044
    cpufreq: resume failed to assert current frequency is what timing core thinks it is.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
