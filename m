Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C41EADDEEB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 08:06:38 +1000 (EST)
Message-Id: <C87FB9C7-DE04-40FC-AA67-89BB7751468F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1241206851-27749-5-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/85xx: add new qe properties for QE based chips
Date: Fri, 1 May 2009 17:04:30 -0500
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-4-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-5-git-send-email-Haiying.Wang@freescale.com>
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

> Add fsl,qe-num-riscs and fsl,qe-num-snums to all the devices trees  
> which have qe
> node.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc832x_mds.dts |    2 ++
> arch/powerpc/boot/dts/mpc832x_rdb.dts |    2 ++
> arch/powerpc/boot/dts/mpc836x_mds.dts |    2 ++
> arch/powerpc/boot/dts/mpc836x_rdk.dts |    2 ++
> arch/powerpc/boot/dts/mpc8568mds.dts  |    2 ++
> 5 files changed, 10 insertions(+), 0 deletions(-)

applied to next

- k
