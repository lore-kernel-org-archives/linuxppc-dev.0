Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0817B67B3F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:38:47 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1112681154.9517.7.camel@gaston> <jek6nf1pcj.fsf@sykes.suse.de>
	<1112829020.9518.202.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 07 Apr 2005 01:38:42 +0200
In-Reply-To: <1112829020.9518.202.camel@gaston> (Benjamin Herrenschmidt's
	message of "Thu, 07 Apr 2005 09:10:19 +1000")
Message-ID: <jefyy31nnh.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Update ppc32-fix-errata-for-some-g3-cpus.patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2005-04-07 at 01:02 +0200, Andreas Schwab wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> 
>> > The previous version of ppc32-fix-errata-for-some-g3-cpus.patch had an
>> > issue that would crash some G4 CPUs on boot. This is fixed in this new
>> > version, please replace the old one and send to linus asap (it's now
>> > been tested on enough CPUs).
>> 
>> Apparently not.  I'm getting "floating point used in kernel" crashes
>> during wakeup on my iBook G3 (750FX).
>
> And does removing that patch fixes it ?

Sorry, I have to take that back.  It doesn't actually cause my wakeup
problems (alone?).  I will try to dig further into that tomorrow.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
