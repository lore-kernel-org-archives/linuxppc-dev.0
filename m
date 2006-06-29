Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 83E0067B97
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 09:16:27 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer handle	anything
	with a layout-id property
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de> <s5hac7yvfhe.wl%tiwai@suse.de>
	<jehd26aa25.fsf@sykes.suse.de> <jeu0631xpr.fsf@sykes.suse.de>
	<1151619973.22380.50.camel@mindpipe>
Date: Fri, 30 Jun 2006 01:16:18 +0200
In-Reply-To: <1151619973.22380.50.camel@mindpipe> (Lee Revell's message of
	"Thu, 29 Jun 2006 18:26:12 -0400")
Message-ID: <jehd231rjx.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	Johannes Berg <johannes@sipsolutions.net>,
	alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Lee Revell <rlrevell@joe-job.com> writes:

> What is the content of /proc/asound/cards?  The patches must have
> changed the card name and failed to create a matching config file
> in /usr/share/alsa/cards.

Thanks for the hint.  I have added 'AppleOnbdAudio cards.PMac' to
/usr/share/alsa/cards/aliases.conf, and it works again.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
