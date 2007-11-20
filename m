Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CA8DDDE99
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:36:52 +1100 (EST)
Date: Tue, 20 Nov 2007 15:35:25 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] powerpc: mpc8xxx MDS board RTC fixes
In-Reply-To: <20071108133706.961af8d2.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0711201535150.17614@blarg.am.freescale.net>
References: <20071108133706.961af8d2.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 Nov 2007, Kim Phillips wrote:

> Now the rtc class ds1374 driver has been added,
> remove the old rtc driver hookup code, add rtc node
> to device trees, and turn on the new driver in the defconfigs.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_mds.dts      |    7 ++++
>  arch/powerpc/boot/dts/mpc834x_mds.dts      |    9 +++++
>  arch/powerpc/boot/dts/mpc836x_mds.dts      |    9 +++++
>  arch/powerpc/configs/mpc832x_mds_defconfig |   48 +++++++++++++++++++++++++++-
>  arch/powerpc/configs/mpc834x_mds_defconfig |   48 +++++++++++++++++++++++++++-
>  arch/powerpc/configs/mpc836x_mds_defconfig |   48 +++++++++++++++++++++++++++-
>  arch/powerpc/configs/mpc8568mds_defconfig  |   48 +++++++++++++++++++++++++++-
>  arch/powerpc/platforms/83xx/mpc832x_mds.c  |   24 --------------
>  arch/powerpc/platforms/83xx/mpc834x_mds.c  |   24 --------------
>  arch/powerpc/platforms/83xx/mpc836x_mds.c  |   24 --------------
>  10 files changed, 213 insertions(+), 76 deletions(-)

applied.

- k
