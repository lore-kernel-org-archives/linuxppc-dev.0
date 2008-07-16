Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDB45DE456
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 00:00:08 +1000 (EST)
Message-Id: <79BB552E-46C3-4CF6-BADF-D5F6B6542213@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080711230445.GD3854@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 5/6] gianfar: Add magic packet and suspend/resume support.
Date: Wed, 16 Jul 2008 09:00:01 -0500
References: <20080711230445.GD3854@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 11, 2008, at 6:04 PM, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |    3 +
> drivers/net/gianfar.c         |  118 ++++++++++++++++++++++++++++++++ 
> ++++++++-
> drivers/net/gianfar.h         |   12 ++++-
> drivers/net/gianfar_ethtool.c |   41 +++++++++++++-
> include/linux/fsl_devices.h   |    1 +
> 5 files changed, 169 insertions(+), 6 deletions(-)

applied.

- k
