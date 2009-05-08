Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66F8BDE396
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:16:29 +1000 (EST)
Message-Id: <B018E63B-540C-4244-9102-523E359B9FEA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090502021656.GE18281@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 5/6] powerpc/85xx: Enable Serial RapidIO for MPC85xx MDS
	boards
Date: Fri, 8 May 2009 09:14:22 -0500
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
	<20090502021656.GE18281@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 9:16 PM, Anton Vorontsov wrote:

> Select HAS_RAPIDIO symbol and add rio nodes for MPC8568E-MDS
> and MPC8569E-MDS boards.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8568mds.dts |   17 +++++++++++++++++
> arch/powerpc/boot/dts/mpc8569mds.dts |   17 +++++++++++++++++
> arch/powerpc/platforms/85xx/Kconfig  |    1 +
> 3 files changed, 35 insertions(+), 0 deletions(-)


applied to next

- k
