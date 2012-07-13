Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA8162C03AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 23:54:55 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: L2sram: Add compatible string to the device
 id list
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342146455-27729-1-git-send-email-b29983@freescale.com>
Date: Fri, 13 Jul 2012 08:54:56 -0500
Message-Id: <AD104C7F-2401-46F5-BC73-39263DE89C2E@kernel.crashing.org>
References: <1342146455-27729-1-git-send-email-b29983@freescale.com>
To: "<b29983@freescale.com>" <b29983@freescale.com>
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 12, 2012, at 9:27 PM, <b29983@freescale.com> =
<b29983@freescale.com> wrote:

> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>=20
> The following platforms are supported:
> mpc8544, mpc8572, mpc8536, p1021, p1025, p1024, p1010.
>=20
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c |   10 ++++++++++
> 1 files changed, 10 insertions(+), 0 deletions(-)

applied to next

- k=
