Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3DFBDE3C2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:28:47 +1000 (EST)
Message-Id: <97AD4EFF-8222-413B-84CA-63C79850B8C2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080410204502.GB20197@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] CPM: Always use new binding.
Date: Mon, 14 Apr 2008 10:28:38 -0500
References: <20080410204502.GB20197@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2008, at 3:45 PM, Scott Wood wrote:
> The kconfig entry can go away once arch/ppc and references to the  
> config in
> drivers are removed.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/platforms/82xx/Kconfig |    3 -
> arch/powerpc/platforms/85xx/Kconfig |    8 -
> arch/powerpc/platforms/8xx/Kconfig  |    4 -
> arch/powerpc/platforms/Kconfig      |    8 +-
> arch/powerpc/sysdev/cpm1.c          |  112 -------
> arch/powerpc/sysdev/cpm2.c          |   97 -------
> arch/powerpc/sysdev/cpm_common.c    |    3 -
> arch/powerpc/sysdev/fsl_soc.c       |  541  
> -----------------------------------
> 8 files changed, 1 insertions(+), 775 deletions(-)

applied.

- k
