Return-Path: <schwab@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 28E2E67A8C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 12:34:29 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1106011958.4533.25.camel@gaston> <je7jmaurl0.fsf@sykes.suse.de>
	<1106100264.4534.135.camel@gaston> <jemzv584yw.fsf@sykes.suse.de>
	<1106175427.5326.21.camel@gaston> <jehdld7wx0.fsf@sykes.suse.de>
	<1106182915.5294.57.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 20 Jan 2005 02:34:24 +0100
In-Reply-To: <1106182915.5294.57.camel@gaston> (Benjamin Herrenschmidt's
	message of "Thu, 20 Jan 2005 12:01:54 +1100")
Message-ID: <jed5w0993z.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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

>>     cpufreq: resume failed to assert current frequency is what timing core thinks it is.
>
> Weird ... Can you try without cpufreq built in the kernel ?

I think this message is unrelated to the problem, it occurs with all
kernels so far.

> Also what is the exact CPU revision ?

It's a 750FX revision 1.18.

> I think you are just experiencing memory corruption...

Yes, I agree, I get completely different crashes whenever I use a slightly
different kernel.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
