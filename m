Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46610DE398
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 00:24:49 +1000 (EST)
Message-Id: <B8843B84-AD04-4455-8A89-AA34B71F4068@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] Drop redundant machine type print in show_cpuinfo
Date: Mon, 29 Sep 2008 09:23:35 -0500
References: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2008, at 4:53 PM, Becky Bruce wrote:

> For many of the embedded boards, "model" and "Machine" are printing
> the same thing; remove the redundant code and allow the generic
> show_cpuinfo to print the model information.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    1 -
> arch/powerpc/platforms/85xx/sbc8560.c             |    1 -
> arch/powerpc/platforms/86xx/gef_sbc610.c          |    8 --------
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    8 --------
> arch/powerpc/platforms/86xx/sbc8641d.c            |    8 --------
> arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1 -
> 6 files changed, 0 insertions(+), 27 deletions(-)

applied.

- k
