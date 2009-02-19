Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6396ADE028
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:43:09 +1100 (EST)
Message-Id: <F557A872-5674-4F24-9781-A46AE855DE72@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090219160223.GA2095@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/83xx: Do not configure or probe disabled FSL DR
	USB controllers
Date: Thu, 19 Feb 2009 10:43:03 -0600
References: <20090219160223.GA2095@oksana.dev.rtsoft.ru>
Cc: Liu Dave <DaveLiu@freescale.com>, Andy Fleming <afleming@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2009, at 10:02 AM, Anton Vorontsov wrote:

> On MPC837X CPUs Dual-Role USB isn't always available (for example DR
> USB pins can be muxed away to eSDHC).
>
> U-Boot adds status = "disabled" property into the DR USB nodes to
> indicate that we must not try to configure or probe Dual-Role USB,
> otherwise we'll break eSDHC support on targets with MPC837X CPUs.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/83xx/usb.c |    3 ++-
> arch/powerpc/sysdev/fsl_soc.c     |    4 ++++
> 2 files changed, 6 insertions(+), 1 deletions(-)


applied to next

- k
