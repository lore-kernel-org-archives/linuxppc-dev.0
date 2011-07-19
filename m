Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 433BBB6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:18:19 +1000 (EST)
Subject: Re: [PATCH 14/14] 85xx: separate cpm2 pic init
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-15-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 09:18:12 -0500
Message-Id: <3552E767-03D3-4E06-A5D3-A306EF266B25@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-15-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:

> Separate handling of CPM2 PIC initialization to =
mpc85xx_cpm2_pic_init()
> function.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/ksi8560.c        |   28 =
+------------------
> arch/powerpc/platforms/85xx/mpc85xx.h        |    7 ++++
> arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   32 =
+--------------------
> arch/powerpc/platforms/85xx/mpc85xx_common.c |   39 =
++++++++++++++++++++++++++
> arch/powerpc/platforms/85xx/sbc8560.c        |   32 =
+--------------------
> arch/powerpc/platforms/85xx/tqm85xx.c        |   35 =
+----------------------
> 6 files changed, 50 insertions(+), 123 deletions(-)

looks fine, move earlier in the sequence.

- k=
