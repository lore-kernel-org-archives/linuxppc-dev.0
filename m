Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C6D392C02C2
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2013 08:14:45 +1100 (EST)
Subject: Re: [PATCH][V3] powerpc: remove the PPC_CLOCK dependency
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363070583-23197-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Tue, 12 Mar 2013 16:14:40 -0500
Message-Id: <11305E37-9A88-414D-879F-B9C2B58EF395@kernel.crashing.org>
References: <1363070583-23197-1-git-send-email-Yuantian.Tang@freescale.com>
To: "<Yuantian.Tang@freescale.com>" <Yuantian.Tang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 12, 2013, at 1:43 AM, <Yuantian.Tang@freescale.com> =
<Yuantian.Tang@freescale.com> wrote:

> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>=20
> Config FSL_SOC does not depend on PPC_CLOCK anymore since the =
following
> commit got merged: 93abe8e (clk: add non CONFIG_HAVE_CLK routines)
> Config CPM does not use PPC_CLOCK either currently. So remove them.
>=20
> PPC_CLOCK also keeps Freescale PowerPC archtecture from supporting =
COMMON_CLK.
>=20
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v3: modified the description
> v2: correct the title
>=20
> arch/powerpc/Kconfig           |    1 -
> arch/powerpc/platforms/Kconfig |    1 -
> 2 files changed, 0 insertions(+), 2 deletions(-)

applied to next

- k=
