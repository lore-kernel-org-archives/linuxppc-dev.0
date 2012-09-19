Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A23AF2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 06:46:40 +1000 (EST)
Date: Wed, 19 Sep 2012 21:46:36 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 5/7] ASoC: fsl: convert pcm030-audio-fabric to a
 platform-driver
Message-ID: <20120919204635.GA12297@opensource.wolfsonmicro.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
 <20120919030324.GO8832@opensource.wolfsonmicro.com>
 <0A40042D85E7C84DB443060EC44B3FD3459868BABB@dekaexchange07.deka.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3459868BABB@dekaexchange07.deka.local>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2012 at 10:35:45AM -0400, Eric Millbrandt wrote:

> That was an artifact of me splitting the changes to pcm030-audio-fabric.c
> into multiple patches.  I changed the driver to a platform device in this
> patch and converted to snd_soc_register_card() in the next patch.  I can
> merge the two patches back together if you think that is cleaner and
> easier to understand.

Yes, please.
