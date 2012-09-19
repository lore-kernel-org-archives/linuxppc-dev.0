Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by ozlabs.org (Postfix) with ESMTP id CADFE2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 06:47:34 +1000 (EST)
Date: Wed, 19 Sep 2012 21:47:31 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2 1/7] ASoC: fsl: add PPC_MPC52xx dependency to
 SND_POWERPC_SOC
Message-ID: <20120919204730.GB12297@opensource.wolfsonmicro.com>
References: <1348066285-87741-1-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348066285-87741-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2012 at 10:51:25AM -0400,  wrote:
> From: Eric Millbrandt <emillbrandt@dekaresearch.com>
> 
> mpc52xx socs need to define SND_POWERPC_SOC to build ASoC drivers.
> 
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
> Changes since v1:
> Patch was "powerpc/52xx: define FSL_SOC"
> Changed from defining FSL_SOC for PPC_MPC52xx to adding PPC_MPC52xx as a
> dependency of SND_POWERPC_SOC as per Anatolij Gustschin's comment.

Patches 2 to 7 appear to have gone AWOL?
