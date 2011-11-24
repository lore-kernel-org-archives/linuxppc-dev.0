Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0461D10085B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:16:07 +1100 (EST)
Subject: Re: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 24 Nov 2011 01:15:40 -0600
Message-Id: <53F71E3E-A3C3-49E8-9209-3398A3EFB93A@kernel.crashing.org>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2011, at 11:56 AM, Dmitry Eremin-Solenikov wrote:

> 85xx board files have a lot of duplication in *_publish_devices()/
> *_declare_of_platform_devices() functions. Merge that into a single
> function common to most of the boards.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/ksi8560.c        |   17 +---------
> arch/powerpc/platforms/85xx/mpc8536_ds.c     |   14 +-------
> arch/powerpc/platforms/85xx/mpc85xx.h        |    2 +
> arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   18 +----------
> arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   14 +-------
> arch/powerpc/platforms/85xx/mpc85xx_common.c |   16 +++++++++
> arch/powerpc/platforms/85xx/mpc85xx_ds.c     |   18 ++---------
> arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   44 =
+------------------------
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |   16 +--------
> arch/powerpc/platforms/85xx/p1022_ds.c       |    5 +--
> arch/powerpc/platforms/85xx/sbc8548.c        |   18 ++---------
> arch/powerpc/platforms/85xx/sbc8560.c        |   18 +----------
> arch/powerpc/platforms/85xx/socrates.c       |   12 +------
> arch/powerpc/platforms/85xx/stx_gp3.c        |   14 +-------
> arch/powerpc/platforms/85xx/tqm85xx.c        |   14 +-------
> arch/powerpc/platforms/85xx/xes_mpc85xx.c    |   18 ++---------
> 16 files changed, 40 insertions(+), 218 deletions(-)

applied to next

- k=
