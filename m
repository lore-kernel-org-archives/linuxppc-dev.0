Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id A0B83DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 23:26:27 +1100 (EST)
Date: Fri, 24 Oct 2008 14:26:16 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: adding more machines to snd-aoa
Message-ID: <20081024122616.GA19424@iram.es>
References: <1224769461.6002.12.camel@johannes.berg>
	<20081023153510.GA28277@iram.es>
	<1224776462.6002.45.camel@johannes.berg>
	<20081023164302.GA29454@iram.es>
	<1224837623.6002.84.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
In-Reply-To: <1224837623.6002.84.camel@johannes.berg>
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


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2008 at 10:40:23AM +0200, Johannes Berg wrote:
> On Thu, 2008-10-23 at 18:43 +0200, Gabriel Paubert wrote:
> 
> > > Can you tell me which devices it has, like does it have line-in,
> > > microphone, headphones, ...?
> > 
> > I'm not an audio specialist, so the symbols used to
> > identify the ports look like hieroglyphs to me, but 
> > The documentation says that the two ports on the
> > back are for headphones and external stereo loudspeakers.
> 
> Right. I'll assume it has a microphone too, built-in. 

I doubt it: 
- no mention found in the doc
- it seems to be output-only (#-inputs in the device tree is 0,
#-outputs is 3).

I have attached the device tree corresponding to the PCI domain.

I could also send you the device tree of my PowerBook G3: it does
have the device-id property with a value of 10, but the parent
node is called davbus instead of i2s. That one definitely has
a microphone...

> Could you try the
> patch below, enable all snd-aoa modules and see what happens?
> 

I won't have time in the next few days, sorry. 

	Regards,
	Gabriel

--9jxsPFA5p3P2qPhR
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="pmac4,3-pci@f2000000.tar.gz"
Content-Transfer-Encoding: base64

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
AAAAAADcXf4Cm8/0xwBoBgA=

--9jxsPFA5p3P2qPhR--
