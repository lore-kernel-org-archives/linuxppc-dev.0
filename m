Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E94B5DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 08:31:15 +1100 (EST)
Subject: Re: adding more machines to snd-aoa
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20081023164302.GA29454@iram.es>
References: <1224769461.6002.12.camel@johannes.berg>
	<20081023153510.GA28277@iram.es>
	<1224776462.6002.45.camel@johannes.berg>
	<20081023164302.GA29454@iram.es>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 08:30:49 +1100
Message-Id: <1224797449.7654.419.camel@pasglop>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Linux User #330250 <linuxuser330250@gmx.net>,
	Sjoerd Simons <sjoerd@luon.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-23 at 18:43 +0200, Gabriel Paubert wrote:
> 
> Yes, on a pristine 2.6.27 kernel right now.
> 
> > Can you tell me which devices it has, like does it have line-in,
> > microphone, headphones, ...?
> 
> I'm not an audio specialist, so the symbols used to
> identify the ports look like hieroglyphs to me, but 
> The documentation says that the two ports on the
> back are for headphones and external stereo loudspeakers.
> 
> And the sound is definitely i2s given the OF entry:
> 
> /proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/device-id

Best if you send a device-tree dump to Johannes.

Cheers,
Ben.
