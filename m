Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 85D20DE4BA
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:48:11 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so182821ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 08:48:08 -0700 (PDT)
Date: Wed, 2 Jul 2008 09:48:04 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Message-ID: <20080702154804.GA23011@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<s5hiqvod37w.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hiqvod37w.wl%tiwai@suse.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 11:50:43AM +0200, Takashi Iwai wrote:
> At Tue, 01 Jul 2008 17:53:30 -0600,
> Grant Likely wrote:
> > diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> > index 18f28ac..c5736e5 100644
> > --- a/sound/soc/Kconfig
> > +++ b/sound/soc/Kconfig
> > @@ -23,6 +23,12 @@ config SND_SOC
> >  	  This ASoC audio support can also be built as a module.  If so, the module
> >  	  will be called snd-soc-core.
> >  
> > +config SND_SOC_OF
> > +	tristate "OF helpers for SoC audio support"
> > +	depends on SND_SOC
> > +	---help---
> > +	  Add support for OpenFirmware device tree descriptions of sound device
> > +
> 
> This is a helper module and not necessarily manually selectable.
> Better to make the other driver selecting this.

Yes, you're right.  I hadn't put too much thought into the Kconfig stuff
for this patch because, at the moment, I'm viewing this as a temporary
solution until ASoCv2 is merged.

Which raises another question: Liam and Mark, what is your opinion on
merging this driver?  Is it something that you would merge with the v1
API and then rework it when v2 is merged?  Or would you rather it be
kept out until v2 is ready?  I haven't even looked at the v2 API yet, so
I don't know how much rework is involved.

Cheers,
g.
