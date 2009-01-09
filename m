Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89846476A6
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 11:19:30 +1100 (EST)
Message-Id: <58CCA2E4-4A1A-4B93-BAE2-A5FB137DB74E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090108013141.GB11165@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/2] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Date: Thu, 8 Jan 2009 18:17:20 -0600
References: <20090108013006.GA31653@oksana.dev.rtsoft.ru>
	<20090108013141.GB11165@oksana.dev.rtsoft.ru>
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2009, at 7:31 PM, Anton Vorontsov wrote:

> This patch adds pcie nodes to the appropriate dts files, plus adds
> some probing code for the boards.
>
> Also, remove of_device_is_avaliable() check from the mpc837x_mds.c
> board file, as mpc83xx_add_bridge() has the same check now.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8315erdb.dts     |   64 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/mpc8377_mds.dts     |   64 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/mpc8377_rdb.dts     |   64 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/mpc8378_mds.dts     |   64 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/mpc8378_rdb.dts     |   64 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |    2 +
> arch/powerpc/platforms/83xx/mpc837x_mds.c |   10 +---
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    2 +
> 8 files changed, 327 insertions(+), 7 deletions(-)

applied

- k
