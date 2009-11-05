Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 516C91015AD
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:11:54 +1100 (EST)
Subject: Re: [PATCH 7/7] powerpc/83xx: Add power management support for
	MPC83xx QE boards
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090915214402.GG24821@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 08:11:48 -0600
Message-Id: <ED2BDB49-F51F-4371-881D-E37F3CC7EE6F@kernel.crashing.org>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214402.GG24821@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2009, at 4:44 PM, Anton Vorontsov wrote:

> Simply add power management controller nodes and sleep properties.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/dts/kmeter1.dts     |    7 +++++++
> arch/powerpc/boot/dts/mpc832x_mds.dts |    9 +++++++++
> arch/powerpc/boot/dts/mpc832x_rdb.dts |    9 +++++++++
> arch/powerpc/boot/dts/mpc836x_mds.dts |    9 +++++++++
> arch/powerpc/boot/dts/mpc836x_rdk.dts |    9 +++++++++
> 5 files changed, 43 insertions(+), 0 deletions(-)

applied to next

- k
