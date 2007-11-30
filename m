Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACB2CDDE26
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 09:14:12 +1100 (EST)
Message-ID: <47508B32.8060108@freescale.com>
Date: Fri, 30 Nov 2007 16:14:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: T Ziomek <ctz001@email.mot.com>
Subject: Re: [PATCH 15/24] powerpc: early debug forces console log level to max
References: <20071130061200.4BAF9DDFAE@ozlabs.org>
	<Pine.LNX.4.64.0711301306520.5450@gauley.ddna.labs.mot.com>	<1196456185.13230.100.camel@pasglop>
	<Pine.LNX.4.64.0711301605540.5450@gauley.ddna.labs.mot.com>
In-Reply-To: <Pine.LNX.4.64.0711301605540.5450@gauley.ddna.labs.mot.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T Ziomek wrote:
> On Sat, 1 Dec 2007, Benjamin Herrenschmidt wrote:
>> Possibly, though you aren't supposed to leave EARLY_DEBUG enabled
>> once you are done debugging :-)
> 
> I'm probably not the only person that would turn it on when needed, think
> "well, no harm in leaving it on for the rest of my development, and it
> might be handy; just turn it off when we're done".
> 
> It's these kind of non-obvious but undocumented things that make a lot of
> OSS code a pain to work with for non-experts [1].  What's the harm in
> giving folks a heads-up?

Well, the config text does say "(dangerous)"...

-Scott
