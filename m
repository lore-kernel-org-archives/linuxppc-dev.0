Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0018FDE02F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:10:32 +1000 (EST)
Message-Id: <8B2A3D71-C756-4281-8FF1-ADEC7861C630@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <1220627327-28852-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: gpio driver for mpc831x/834x/837x with OF
	bindings
Date: Fri, 19 Sep 2008 13:10:26 -0500
References: <1220627327-28852-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 5, 2008, at 10:08 AM, Peter Korsgaard wrote:

> Structured similar to the existing QE GPIO support.
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
> .../powerpc/dts-bindings/fsl/83xx_gpio.txt         |   33 +++++
> arch/powerpc/sysdev/Kconfig                        |    9 ++
> arch/powerpc/sysdev/Makefile                       |    1 +
> arch/powerpc/sysdev/mpc83xx_gpio.c                 |  141 +++++++++++ 
> +++++++++
> 4 files changed, 184 insertions(+), 0 deletions(-)
> create mode 100644 Documentation/powerpc/dts-bindings/fsl/ 
> 83xx_gpio.txt
> create mode 100644 arch/powerpc/sysdev/mpc83xx_gpio.c

So we need to make this mpc8xxx_gpio.c 83xx, 8610, 85xx all have the  
same GPIO hw.

- k
