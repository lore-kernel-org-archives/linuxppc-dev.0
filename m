Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id 6F52C679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 08:26:16 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
From: Lee Revell <rlrevell@joe-job.com>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jeu0631xpr.fsf@sykes.suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 18:26:12 -0400
Message-Id: <1151619973.22380.50.camel@mindpipe>
Mime-Version: 1.0
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

On Thu, 2006-06-29 at 23:03 +0200, Andreas Schwab wrote:
> Andreas Schwab <schwab@suse.de> writes:
> 
> > Takashi Iwai <tiwai@suse.de> writes:
> >
> >> At Mon, 26 Jun 2006 22:49:04 +0200,
> >> Andreas Schwab wrote:
> >>> 
> >>> Johannes Berg <johannes@sipsolutions.net> writes:
> >>> 
> >>> > This patch removes from snd-powermac the code that check for the layout-id
> >>> > and instead adds code that makes it refuse loading when a layout-id property
> >>> > is present, nothing that snd-aoa should be used.
> >>> 
> >>> Can we get snd-powermac back as long as snd-aoa is lacking all those
> >>> features from snd-powermac?
> >>
> >> What functions are missing?
> >
> > Sound on PowerMac7,2, DRC on TAS, probably more.
> 
> Another problem is that the sound device can only be opened once.
> 

What is the content of /proc/asound/cards?  The patches must have
changed the card name and failed to create a matching config file
in /usr/share/alsa/cards.

Lee
