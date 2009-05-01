Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD1D1DDF34
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 08:14:59 +1000 (EST)
Message-Id: <340A2C2A-04B4-4DD4-A18C-A15477F7071B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1241206851-27749-4-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 6/6 v2] powerpc/85xx: Add MPC8569MDS board support
Date: Fri, 1 May 2009 17:12:50 -0500
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-4-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 2:40 PM, Haiying Wang wrote:

> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> v2 change: rename "num-riscs" to "fsl,qe-num-riscs", and "num-snums"  
> to
> "fsl,qe-num-snums".
>
> arch/powerpc/boot/dts/mpc8569mds.dts      |  514 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   23 ++
> 2 files changed, 537 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc8569mds.dts


applied to next

- k
