Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F004F67B59
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:13:40 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1152259477.15068.15.camel@localhost>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<1152259477.15068.15.camel@localhost>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 18:13:24 +1000
Message-Id: <1152260005.9862.53.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org,
	Lee Revell <rlrevell@joe-job.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-07 at 10:04 +0200, Johannes Berg wrote:
> On Fri, 2006-07-07 at 15:38 +1000, Benjamin Herrenschmidt wrote:
> 
> > There is still an issue... wether to enable softvol or not... With
> > snd-aoa, the card name is always the same but wether it has hardware
> > volume control or not (Toonie doesn't) is not known... Alsa should have
> > ways to add softvol automatically if no master volume control exist.
> 
> Hm, good point. I probably need to completely revamp the card handling
> and not create a card object before the codecs are registered. That way,
> I could influence the naming through the codecs.

Maybe ... or not... I'd rather not bother. I think Alsa should be able
to create softvol if there is no Master volume...

Ben.
