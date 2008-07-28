Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D80A7DE353
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 22:42:47 +1000 (EST)
Message-Id: <B9722E68-A90D-4909-8DDA-F7A94D3691D3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807281043.22736.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCHv4] cpm2: Implement GPIO LIB API on CPM2 Freescale SoC.
Date: Mon, 28 Jul 2008 07:42:22 -0500
References: <4808D75B.9000002@scram.de>
	<200807241800.27146.laurentp@cse-semaphore.com>
	<1C0E875E-1FFA-4FDB-BF87-36D9A03939E0@kernel.crashing.org>
	<200807281043.22736.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 28, 2008, at 3:43 AM, Laurent Pinchart wrote:

> Based on earlier work by Laurent Pinchart.
>
> This patch implement GPIO LIB support for the CPM2 GPIOs.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> Cc: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> arch/powerpc/platforms/Kconfig   |    2 +
> arch/powerpc/sysdev/cpm2.c       |   11 ++++
> arch/powerpc/sysdev/cpm_common.c |  123 +++++++++++++++++++++++++++++ 
> +++++++++
> include/asm-powerpc/cpm.h        |    3 +
> 4 files changed, 139 insertions(+), 0 deletions(-)

applied.

- k
