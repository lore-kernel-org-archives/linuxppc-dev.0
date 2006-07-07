Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F81D679E2
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 15:39:02 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jehd231rjx.fsf@sykes.suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 15:38:40 +1000
Message-Id: <1152250720.9862.32.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org,
	Lee Revell <rlrevell@joe-job.com>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-30 at 01:16 +0200, Andreas Schwab wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > What is the content of /proc/asound/cards?  The patches must have
> > changed the card name and failed to create a matching config file
> > in /usr/share/alsa/cards.
> 
> Thanks for the hint.  I have added 'AppleOnbdAudio cards.PMac' to
> /usr/share/alsa/cards/aliases.conf, and it works again.

There is still an issue... wether to enable softvol or not... With
snd-aoa, the card name is always the same but wether it has hardware
volume control or not (Toonie doesn't) is not known... Alsa should have
ways to add softvol automatically if no master volume control exist.

Ben.
