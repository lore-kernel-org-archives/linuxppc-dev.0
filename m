Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D59681007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 19:25:44 +1100 (EST)
Subject: Re: [patch 1/1] drivers/edac/mpc85xx_edac.c: fix memory controller
 compatible for edac
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <201111152252.pAFMqMYB032421@wpaz1.hot.corp.google.com>
Date: Thu, 24 Nov 2011 02:25:29 -0600
Message-Id: <B815F306-2881-4BE6-8660-AF3783A0A36C@kernel.crashing.org>
References: <201111152252.pAFMqMYB032421@wpaz1.hot.corp.google.com>
To: akpm@linux-foundation.org
Cc: Shaohui.Xie@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 15, 2011, at 4:52 PM, akpm@linux-foundation.org wrote:

> From: Shaohui Xie <Shaohui.Xie@freescale.com>
> Subject: drivers/edac/mpc85xx_edac.c: fix memory controller compatible =
for edac
>=20
> compatible in dts has been changed, so the driver needs to be updated
> accordingly.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
> drivers/edac/mpc85xx_edac.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

applied to merge

- k=
