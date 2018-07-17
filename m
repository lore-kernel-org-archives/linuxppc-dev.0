Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VR1F1R3YzF3J5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:43:27 +1000 (AEST)
Date: Tue, 17 Jul 2018 18:43:20 +0200
Message-ID: <20180717184320.Horde.oDFr4qk9a_r69egW2Z04lQ8@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Diana Craciun <diana.craciun@nxp.com>
Cc: leoyang.li@nxp.com, bharat.bhushan@nxp.com, oss@buserror.net,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/6] powerpc/fsl: Speculation barrier for NXP PowerPC
 Book3E
In-Reply-To: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Diana Craciun <diana.craciun@nxp.com> a =C3=A9crit=C2=A0:

> Implement barrier_nospec for NXP PowerPC Book3E processors.
>
> Diana Craciun (6):
>   Disable the speculation barrier from the command line
>   Document nospectre_v1 kernel parameter.
>   Make stf barrier PPC_BOOK3S_64 specific.
>   Enable cpu vulnerabilities reporting for NXP PPC BOOK3E
>   Add barrier_nospec implementation for NXP PowerPC Book3E
>   powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit
>     platforms

This list doesn't corresponds to the names of following 6 patches

Christophe

>
>  Documentation/admin-guide/kernel-parameters.txt |  4 +++
>  arch/powerpc/Kconfig                            |  7 ++++-
>  arch/powerpc/include/asm/barrier.h              | 12 ++++++---
>  arch/powerpc/include/asm/setup.h                |  6 ++++-
>  arch/powerpc/kernel/Makefile                    |  3 ++-
>  arch/powerpc/kernel/entry_32.S                  | 10 +++++++
>  arch/powerpc/kernel/module.c                    |  4 ++-
>  arch/powerpc/kernel/security.c                  | 17 +++++++++++-
>  arch/powerpc/kernel/setup-common.c              |  2 ++
>  arch/powerpc/kernel/vmlinux.lds.S               |  4 ++-
>  arch/powerpc/lib/feature-fixups.c               | 35=20=20
>=20++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/setup.c          |  1 -
>  arch/powerpc/platforms/pseries/setup.c          |  1 -
>  13 files changed, 94 insertions(+), 12 deletions(-)
>
> --
> History:
> v3 --> v4
> - fixed compilation issues
>
> v2 --> v3
> - addressed review comments
> - included the 32bit sanitization in the same patch series
>
> v1 --> v2
> - added implementation for cpu_show_spectre_x functions
> - the mitigation is no longer enabled through device tree options
>
> 2.5.5
