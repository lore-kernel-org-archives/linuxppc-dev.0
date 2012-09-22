Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 657072C0183
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 01:02:29 +1000 (EST)
Date: Sat, 22 Sep 2012 11:02:24 -0400
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 3/3] ASoC: fsl: register the wm9712-codec
Message-ID: <20120922150223.GG4495@opensource.wolfsonmicro.com>
References: <1348151805-93991-1-git-send-email-emillbrandt@dekaresearch.com>
 <1348151805-93991-3-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348151805-93991-3-git-send-email-emillbrandt@dekaresearch.com>
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

On Thu, Sep 20, 2012 at 10:36:45AM -0400, Eric Millbrandt wrote:
> The mpc5200-psc-ac97 driver does not enumerate attached ac97 devices, so
> register the device here.

Applied, thanks.
