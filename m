Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A781F67A44
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 07:03:34 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer handle	anything
	with a layout-id property
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de> <s5hac7yvfhe.wl%tiwai@suse.de>
	<jehd26aa25.fsf@sykes.suse.de>
Date: Thu, 29 Jun 2006 23:03:12 +0200
In-Reply-To: <jehd26aa25.fsf@sykes.suse.de> (Andreas Schwab's message of "Tue,
	27 Jun 2006 17:32:34 +0200")
Message-ID: <jeu0631xpr.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@suse.de> writes:

> Takashi Iwai <tiwai@suse.de> writes:
>
>> At Mon, 26 Jun 2006 22:49:04 +0200,
>> Andreas Schwab wrote:
>>> 
>>> Johannes Berg <johannes@sipsolutions.net> writes:
>>> 
>>> > This patch removes from snd-powermac the code that check for the layout-id
>>> > and instead adds code that makes it refuse loading when a layout-id property
>>> > is present, nothing that snd-aoa should be used.
>>> 
>>> Can we get snd-powermac back as long as snd-aoa is lacking all those
>>> features from snd-powermac?
>>
>> What functions are missing?
>
> Sound on PowerMac7,2, DRC on TAS, probably more.

Another problem is that the sound device can only be opened once.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
