Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 50927B722A
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2011 03:13:07 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAKGD3Qe000322
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2011 10:13:04 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1251.1)
Subject: Re: [PATCH 01/29] powerpc/85xx: Simplify P1020RDB CAMP dts using
 includes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
Date: Sun, 20 Nov 2011 10:13:09 -0600
Message-Id: <6B21D6FE-C870-406E-AA4E-6DEBE6134BD3@kernel.crashing.org>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2011, at 1:15 AM, Kumar Gala wrote:

> If we include the p1020rdb.dts instead of p1020si.dts we greatly =
reduce
> duplication and maintenance.  We can just list which devices are
> disabled for the given core and mpic protected sources.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |  154 =
+------------------------
> arch/powerpc/boot/dts/p1020rdb_camp_core1.dts |   11 +--
> 2 files changed, 4 insertions(+), 161 deletions(-)

applied 1-29, and v2 for p2041 & p1022 to 'next'

- k=
