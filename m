Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0E4367B5A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2005 01:08:05 +1000 (EST)
Message-ID: <425A92B1.6080907@sipsolutions.net>
Date: Mon, 11 Apr 2005 17:07:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1113113792.9517.476.camel@gaston>
In-Reply-To: <1113113792.9517.476.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] pmac: sound support for latest laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

>This patch hacks the current Alsa snd-powermac driver to add support for
>recent machine models with the tas3004 chip, that is basically new
>laptop models. The Mac Mini is _NOT_ yet supported by this patch (soon
>soon ...). The G5s (iMac or Desktop) will need the rewritten sound
>driver on which I'm working on (I _might_ get a hack for analog only on
>some G5s on the current driver, but no promise).
>  
>
That's cool. I do have one slight problem with it though: When I turn 
down the Master mixer and up PCM it sounds badly overmodulated. I can 
keep PCM at about 75% and turn up master, and all is fine. Would it make 
sense to limit the PCM mixer to about 75% of its current limits, or how 
does that actually work in the hardware?

johannes
