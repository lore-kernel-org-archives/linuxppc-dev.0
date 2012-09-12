Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by ozlabs.org (Postfix) with ESMTP id 0E1DF2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:20:37 +1000 (EST)
Date: Wed, 12 Sep 2012 11:20:28 +0800
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 5/5] ASoC: fsl: mpc5200 remove pcm030 and efika audio
 fabric
Message-ID: <20120912032026.GI9162@opensource.wolfsonmicro.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-6-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347416089-23393-6-git-send-email-emillbrandt@dekaresearch.com>
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

On Tue, Sep 11, 2012 at 10:14:49PM -0400, Eric Millbrandt wrote:
> MPC5200 ASoC setup can now be done in the device tree.

I only noticed DT bindings being added for pcm030, not for efika?
