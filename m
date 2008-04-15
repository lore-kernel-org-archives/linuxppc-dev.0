Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2112DE59D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:20:57 +1000 (EST)
Message-Id: <0BBE702D-C315-4884-9169-46EDF42BA509@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080415185234.GA10579@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] fsl_soc: Factor fsl_get_sys_freq() out of the wdt and spi
	inits.
Date: Tue, 15 Apr 2008 18:20:49 -0500
References: <20080415185234.GA10579@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 1:52 PM, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   70 +++++++++++++++++ 
> +----------------------
> arch/powerpc/sysdev/fsl_soc.h |    1 +
> 2 files changed, 33 insertions(+), 38 deletions(-)

applied.

- k
