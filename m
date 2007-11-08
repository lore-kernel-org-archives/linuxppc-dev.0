Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2253DDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:01:45 +1100 (EST)
In-Reply-To: <20071108133706.961af8d2.kim.phillips@freescale.com>
References: <20071108133706.961af8d2.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F67D40A1-D8C9-4F96-A526-E848FDFDEA0B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mpc8xxx MDS board RTC fixes
Date: Thu, 8 Nov 2007 13:57:59 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 8, 2007, at 1:37 PM, Kim Phillips wrote:

> Now the rtc class ds1374 driver has been added,
> remove the old rtc driver hookup code, add rtc node
> to device trees, and turn on the new driver in the defconfigs.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_mds.dts      |    7 ++++
>  arch/powerpc/boot/dts/mpc834x_mds.dts      |    9 +++++
>  arch/powerpc/boot/dts/mpc836x_mds.dts      |    9 +++++
>  arch/powerpc/configs/mpc832x_mds_defconfig |   48 +++++++++++++++++ 
> ++++++++++-
>  arch/powerpc/configs/mpc834x_mds_defconfig |   48 +++++++++++++++++ 
> ++++++++++-
>  arch/powerpc/configs/mpc836x_mds_defconfig |   48 +++++++++++++++++ 
> ++++++++++-
>  arch/powerpc/configs/mpc8568mds_defconfig  |   48 +++++++++++++++++ 
> ++++++++++-
>  arch/powerpc/platforms/83xx/mpc832x_mds.c  |   24 --------------
>  arch/powerpc/platforms/83xx/mpc834x_mds.c  |   24 --------------
>  arch/powerpc/platforms/83xx/mpc836x_mds.c  |   24 --------------
>  10 files changed, 213 insertions(+), 76 deletions(-)

should the mpc8568mds.dts be updated?

Also, what code is parsing the device tree for the rtc node?

- k
