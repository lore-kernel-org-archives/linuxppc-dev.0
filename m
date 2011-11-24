Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 597271007D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:15:47 +1100 (EST)
Subject: Re: [PATCH 1/6] powerpc/85xx: separate cpm2 pic init
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 24 Nov 2011 01:15:32 -0600
Message-Id: <660F0E01-CCE7-4124-9919-76593B18B9A9@kernel.crashing.org>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
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

> Separate handling of CPM2 PIC initialization to =
mpc85xx_cpm2_pic_init()
> function.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/Makefile         |    2 +
> arch/powerpc/platforms/85xx/ksi8560.c        |   29 +--------------
> arch/powerpc/platforms/85xx/mpc8536_ds.c     |    2 +
> arch/powerpc/platforms/85xx/mpc85xx.h        |    9 +++++
> arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   34 ++----------------
> arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    2 +
> arch/powerpc/platforms/85xx/mpc85xx_common.c |   49 =
++++++++++++++++++++++++++
> arch/powerpc/platforms/85xx/mpc85xx_ds.c     |    2 +
> arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    2 +
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |    2 +
> arch/powerpc/platforms/85xx/p1022_ds.c       |    2 +
> arch/powerpc/platforms/85xx/sbc8560.c        |   34 ++----------------
> arch/powerpc/platforms/85xx/socrates.c       |    1 +
> arch/powerpc/platforms/85xx/stx_gp3.c        |   37 =
++------------------
> arch/powerpc/platforms/85xx/tqm85xx.c        |   37 =
++------------------
> arch/powerpc/platforms/85xx/xes_mpc85xx.c    |    2 +
> 16 files changed, 89 insertions(+), 157 deletions(-)
> create mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
> create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_common.c

applied to next

- k=
