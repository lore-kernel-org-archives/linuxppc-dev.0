Return-Path: <B20052@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91A1D2C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 18:10:51 +1100 (EST)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 4/5] powerpc/fsl-booke: Add B4_QDS board support
Date: Thu, 4 Apr 2013 07:10:41 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749151B28@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1364886968-9634-1-git-send-email-shaveta@freescale.com>
 <1364886968-9634-3-git-send-email-shaveta@freescale.com>
 <13F7FFD3-2CFB-463F-84D2-2613D2B697E1@kernel.crashing.org>
In-Reply-To: <13F7FFD3-2CFB-463F-84D2-2613D2B697E1@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Wednesday, April 03, 2013 10:12 PM
To: Leekha Shaveta-B20052
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] powerpc/fsl-booke: Add B4_QDS board support


On Apr 2, 2013, at 2:16 AM, Shaveta Leekha wrote:

> - Add support for B4 board in board file b4_qds.c, It is common for=20
> B4860, B4420 and B4220QDS as they share same QDS board
> - Add B4QDS support in Kconfig and Makefile
>=20
> B4860QDS is a high-performance computing evaluation, development and=20
> test platform supporting the B4860 QorIQ Power Architecture processor,=20
> with following major features:
>=20
>   - Four dual-threaded e6500 Power Architecture processors
>     organized in one cluster-each core runs up to 1.8 GHz
>   - Two DDR3/3L controllers for high-speed memory interface each
>     runs at up to 1866.67 MHz
>   - CoreNet fabric that fully supports coherency using MESI protocol
>     between the e6500 cores, SC3900 FVP cores, memories and
>     external interfaces.
>   - Data Path Acceleration Architecture having FMAN, QMan, BMan, SEC 5.3 =
and RMAN
>   - Large internal cache memory with snooping and stashing capabilities
>   - Sixteen 10-GHz SerDes lanes that serve:
>       - Two SRIO interfaces. Each supports up to 4 lanes and
>         a total of up to 8 lanes
>       - Up to 8-lanes Common Public Radio Interface (CPRI) controller
>         for glue-less antenna connection
>       - Two 10-Gbit Ethernet controllers (10GEC)
>       - Six 1G/2.5-Gbit Ethernet controllers for network communications
>       - PCI Express controller
>       - Debug (Aurora)
>   - Various system peripherals
>=20
> B4420 and B4220 have some differences in comparison to B4860 with=20
> fewer core/clusters(both SC3900 and e6500), fewer DDR controllers, fewer =
serdes lanes, fewer SGMII interfaces and reduced target frequencies.
>=20
> Key differences between B4860 and B4420:
> B4420 has:
>   - Fewer e6500 cores:
>       1 cluster with 2 e6500 cores
>   - Fewer SC3900 cores/clusters:
>       1 cluster with 2 SC3900 cores per cluster
>   - Single DDRC @ 1.6GHz
>   - 2 X 4 lane serdes
>   - 3 SGMII interfaces
>   - no sRIO
>   - no 10G
>=20
> Key differences between B4860 and B4220:
> B4220 has:
>   - Fewer e6500 cores:
>       1 cluster with 1 e6500 core
>   - Fewer SC3900 cores/clusters:
>       1 cluster with 2 SC3900 cores per cluster
>   - Single DDRC @ 1.33GHz
>   - 2 X 2 lane serdes
>   - 2 SGMII interfaces
>   - no sRIO
>   - no 10G
>=20
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig  |   17 ++++++
> arch/powerpc/platforms/85xx/Makefile |    1 +
> arch/powerpc/platforms/85xx/b4_qds.c |  102=20
> ++++++++++++++++++++++++++++++++++
> 3 files changed, 120 insertions(+), 0 deletions(-) create mode 100644=20
> arch/powerpc/platforms/85xx/b4_qds.c

commit messages should line wrap at 75 chars.

- k
[SL] Ok, will do that.
Regards,
Shaveta=20
