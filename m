Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by ozlabs.org (Postfix) with ESMTP id 518452C01F0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 01:01:59 +1000 (EST)
Date: Sat, 22 Sep 2012 11:01:54 -0400
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 2/3] ASoC: fsl: pcm030-audio-fabric use
 snd_soc_register_card
Message-ID: <20120922150153.GF4495@opensource.wolfsonmicro.com>
References: <1348151805-93991-1-git-send-email-emillbrandt@dekaresearch.com>
 <1348151805-93991-2-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348151805-93991-2-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2012 at 10:36:44AM -0400, Eric Millbrandt wrote:
> Convert pcm030-audio-fabric to use the new snd_soc_register_card api
> instead of the older method of registering a separate platform device.
> Create the dai_link to the mpc5200_psc_ac97 platform using the device tree.
> Convert the pcm030-audio-fabric driver to a platform-driver and add a
> remove function.

Applied, thanks.
