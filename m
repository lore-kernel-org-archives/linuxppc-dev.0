Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9B73CB7234
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2011 03:13:36 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAKGD3Qf000322
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2011 10:13:33 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1251.1)
Subject: Re: [PATCH] powerpc/85xx: Fix compile error on p3060_qds.c
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321804775-15455-1-git-send-email-galak@kernel.crashing.org>
Date: Sun, 20 Nov 2011 10:13:39 -0600
Message-Id: <3DA35691-4440-449F-AFD4-000D154A0355@kernel.crashing.org>
References: <1321804775-15455-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 20, 2011, at 9:59 AM, Kumar Gala wrote:

> arch/powerpc/platforms/85xx/p3060_qds.c: In function =
'__machine_initcall_p3060_qds_declare_of_platform_devices':
> arch/powerpc/platforms/85xx/p3060_qds.c:73:1: error: implicit =
declaration of function 'declare_of_platform_devices'
>=20
> declare_of_platform_devices should have been =
corenet_ds_publish_devices.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/85xx/p3060_qds.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge

- k=
