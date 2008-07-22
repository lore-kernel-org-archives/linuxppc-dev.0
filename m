Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by ozlabs.org (Postfix) with ESMTP id 8B1CCDE169
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 07:22:24 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so2348000qbc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:22:22 -0700 (PDT)
Date: Tue, 22 Jul 2008 17:21:58 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH v3 1/3] ALSA SoC: Add OpenFirmware helper for matching
	bus and codec drivers
Message-ID: <20080722212158.GB12412@secretlab.ca>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 12:38:30PM -0400, Jon Smirl wrote:
> On 7/22/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  +int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
> >  +                             void *codec_data, struct snd_soc_dai *dai,
> >  +                             struct device_node *node);
> >  +
> >  +int of_snd_soc_register_platform(struct snd_soc_platform *platform,
> >  +                                struct device_node *node,
> >  +                                struct snd_soc_dai *cpu_dai);
> >  +
> 
> This doesn't compile for me.  Where is struct snd_soc_dai being defined?
> 
> It used to be....
> 
> +int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
> +			      void *codec_data, struct snd_soc_codec_dai *dai,
> +			      struct device_node *node);
> +
> +int of_snd_soc_register_platform(struct snd_soc_platform *platform,
> +				 struct device_node *node,
> +				 struct snd_soc_cpu_dai *cpu_dai);
> 

I had to change it to match what is in Linus' current top of tree.  The
snd_soc_cpu_dai and snd_soc_codec_dai structures have been merged.

g.
