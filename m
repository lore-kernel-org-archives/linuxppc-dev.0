Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4DD6FDE7B5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:21:28 +1000 (EST)
Message-Id: <0E398265-2092-4FFB-8C92-D9A914195673@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080708173640.GB7140@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 2/2] powerpc/fsl_soc: gianfar: don't probe disabled devices
Date: Tue, 15 Jul 2008 08:21:22 -0500
References: <20080708173640.GB7140@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 8, 2008, at 12:36 PM, Anton Vorontsov wrote:

> Freescale ships MPC8315E-RDB boards in two variants:
>
> 1. With TSEC1 ethernet support and USB UTMI PHY;
> 2. Without TSEC1 support, but with USB ULPI PHY in addition.
>
> For the second case U-Boot will add status = "disabled"; property
> into the TSEC1 node, so Linux should not try to probe it.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)

applied.

- k
