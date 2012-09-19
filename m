Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1A1222C01E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 13:03:59 +1000 (EST)
Date: Tue, 18 Sep 2012 23:03:54 -0400
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 2/7] ASoC: fsl: mpc5200 combine psc_dma platform data
Message-ID: <20120919030353.GP8832@opensource.wolfsonmicro.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-3-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347572596-37540-3-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2012 at 05:43:11PM -0400, Eric Millbrandt wrote:
> The mpc5200_psc_ac97 and mpc5200_psc_i2s modules rely on shared platform data
> with mpc5200_dma.

Applied, thanks.
