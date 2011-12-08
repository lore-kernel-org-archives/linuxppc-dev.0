Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BE0C31007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 18:28:24 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pB87SKHb021503
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 01:28:21 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1251.1)
Subject: Re: [PATCH] powerpc/fsl: Update defconfigs to enable some standard
 FSL HW features
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1323328285-11969-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 8 Dec 2011 01:28:37 -0600
Message-Id: <790A4FBA-4B03-448F-9982-D69D7A971572@kernel.crashing.org>
References: <1323328285-11969-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 8, 2011, at 1:11 AM, Kumar Gala wrote:

> corenet64_smp_defconfig:
> - enabled rapidio
> 
> corenet32_smp_defconfig:
> - enabled hugetlbfs, rapidio
> 
> mpc85xx_smp_defconfig:
> - enabled P1010RDB, hugetlbfs, SPI, SDHC, Crypto/CAAM
> 
> mpc85xx_smp_defconfig:
> - enabled hugetlbfs, SPI, SDHC, Crypto/CAAM
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/configs/corenet32_smp_defconfig |   10 ++++++----
> arch/powerpc/configs/corenet64_smp_defconfig |    3 ++-
> arch/powerpc/configs/mpc85xx_defconfig       |   17 ++++++++++++-----
> arch/powerpc/configs/mpc85xx_smp_defconfig   |   18 +++++++++++++-----
> 4 files changed, 33 insertions(+), 15 deletions(-)

applied to merge

- k
