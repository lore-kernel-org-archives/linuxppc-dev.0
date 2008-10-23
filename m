Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 1465BDDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 03:43:12 +1100 (EST)
Date: Thu, 23 Oct 2008 18:43:02 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: adding more machines to snd-aoa
Message-ID: <20081023164302.GA29454@iram.es>
References: <1224769461.6002.12.camel@johannes.berg>
	<20081023153510.GA28277@iram.es>
	<1224776462.6002.45.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1224776462.6002.45.camel@johannes.berg>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux User #330250 <linuxuser330250@gmx.net>,
	Sjoerd Simons <sjoerd@luon.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 05:41:02PM +0200, Johannes Berg wrote:
> On Thu, 2008-10-23 at 17:35 +0200, Gabriel Paubert wrote:
> 
> > On my almost 8 years old PowerMac (PowerMac3,4 accorfing to OF):
> > 
> > $ find /proc/device-tree/ -wholename '*sound/device-id' | xargs hd
> > 00000000  00 00 00 0e                                       |....|
> > 00000004
> > 
> > or 14 in decimal.
> 
> Cool. This thing uses snd-powermac, right? 

Yes, on a pristine 2.6.27 kernel right now.

> Can you tell me which devices it has, like does it have line-in,
> microphone, headphones, ...?

I'm not an audio specialist, so the symbols used to
identify the ports look like hieroglyphs to me, but 
The documentation says that the two ports on the
back are for headphones and external stereo loudspeakers.

And the sound is definitely i2s given the OF entry:

/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/device-id

	Regards,
	Gabriel
