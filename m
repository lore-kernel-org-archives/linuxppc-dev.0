Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE0192C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 22:09:06 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Wood Scott-B07421 <B07421@freescale.com>,
 Yoder Stuart-B08248 <B08248@freescale.com>, Yang James-RA8135
 <RA8135@freescale.com>
Subject: RE: [PATCH 0/2 v3] powerpc: Make ptrace work reliably
Date: Tue, 11 Jun 2013 12:08:57 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07066BD7@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1369196459-17275-1-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1369196459-17275-1-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Ping;=20
Please review this patchset ..=20

Thanks
-Bharat

> -----Original Message-----
> From: Bhushan Bharat-R65777
> Sent: Wednesday, May 22, 2013 9:51 AM
> To: galak@kernel.crashing.org; benh@kernel.crashing.org; linuxppc-
> dev@lists.ozlabs.org; Wood Scott-B07421; Yoder Stuart-B08248; Yang James-=
RA8135
> Cc: Bhushan Bharat-R65777
> Subject: [PATCH 0/2 v3] powerpc: Make ptrace work reliably
>=20
> From: Bharat Bhushan <bharat.bhushan@freescale.com>
>=20
> v2->v3
>  - Load PACACURRENT immediately after _MSR(r1), and load DBCR0
>    just after "beq resume_kernel
>  - Added lat_sysycal results before and after the patch
>=20
> v1->v2
>  - Subject line was missing 0/2, 1/2, 2/2
>=20
> Bharat Bhushan (2):
>   powerpc: debug control and status registers are 32bit =3D> This patch m=
akes
> debug control and status registers as 32bit as they are.
>    This does not fix anything
>=20
>   powerpc: restore dbcr0 on user space exit =3D> This patch fixes the ptr=
ace
> reliability issue. The description is the patch
>    describes one of the case where it does not work reliably
>=20
>  arch/powerpc/include/asm/processor.h |    8 ++++----
>  arch/powerpc/kernel/asm-offsets.c    |    1 +
>  arch/powerpc/kernel/entry_64.S       |   28 ++++++++++++++++++++++++----
>  3 files changed, 29 insertions(+), 8 deletions(-)
