Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34FE6B70A6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:16:23 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc/85xx: Cleanup QE initialization for
	MPC85xxMDS boards
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100608195557.GC11446@oksana.dev.rtsoft.ru>
Date: Wed, 4 Aug 2010 14:15:57 -0500
Message-Id: <4391A09A-CB22-4C40-A965-6140060F530B@kernel.crashing.org>
References: <20100608195557.GC11446@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2010, at 2:55 PM, Anton Vorontsov wrote:

> The mpc85xx_mds_setup_arch() function is incomprehensible
> and unmaintainable. Factor out all QE specific stuff into
> mpc85xx_mds_qe_init() and mpc85xx_mds_reset_ucc_phys().
>=20
> Also move QE stuff out of mpc85xx_mds_pic_init().
>=20
> The diff is unreadable, but only because the code was so. ;-)
> It should be better now, and less indented.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |  272 =
+++++++++++++++--------------
> 1 files changed, 143 insertions(+), 129 deletions(-)

applied to next

- k=
