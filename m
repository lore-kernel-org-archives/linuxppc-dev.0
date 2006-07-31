Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6A5867B5D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 04:17:09 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] remove bogomips from /proc/cpuinfo
References: <20060731125904.GA1997@suse.de>
	<200607311946.18331.arnd.bergmann@de.ibm.com>
	<20060731174924.GA4273@suse.de>
Date: Mon, 31 Jul 2006 20:17:05 +0200
In-Reply-To: <20060731174924.GA4273@suse.de> (Olaf Hering's message of "Mon,
	31 Jul 2006 19:49:24 +0200")
Message-ID: <jewt9tfxlq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering <olh@suse.de> writes:

>  On Mon, Jul 31, Arnd Bergmann wrote:
>
>> On Monday 31 July 2006 14:59, Olaf Hering wrote:
>> > Remove bogomips from /proc/cpuinfo.
>> > It is now really bogus since "timebase-frequency" is shown.
>> 
>> Well, but it's still part of the ABI, right?
>> How do you determine that there are no broken applications
>> still relying on it?
>
> Everything works on a G5, as example. Alpha doesnt have it either.
> What pratical value had bogomips for an application?

What harm does it do?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
