Return-Path: <B16395@freescale.com>
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: FW: [PATCH 0/3] powerpc/mpic: Enhancements for FSL MPIC. 
Date: Fri, 15 Jun 2012 22:16:29 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D11D558@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,
If possible could you please review this patch set.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Sunday, June 03, 2012 1:11 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Sethi Varun-B16395
> Subject: [PATCH 0/3] powerpc/mpic: Enhancements for FSL MPIC.
>=20
> This patchset adds/fixes the following functionality specific to the FSL
> MPIC:
> 1. Fix support for timer group B interrupts. Previously these were not
> getting initialized.
>=20
> 2. Use the MPIC_LARGE_VECTORS flag while intializing FSL MPIC.
> This prevents us from eating in to hardware vector number space (MSIs)
> while setting up internal sources.
>=20
> 3.Cascaded handling for the MPIC error interrupt. This is possible with
> FSL MPIC version >=3D 4.1.
>=20
> The patches are based on "next" branch of Benjamin Herrenschmidt's
> powerpc linux tree.
>=20
> Varun Sethi (3):
>   Support time group b on freescale chips.
>   Use MPIC_LARGE_VECTORS flag for Freescale MPIC.
>   Add support for cascaded error interrupt handling.
>=20
>  arch/powerpc/include/asm/mpic.h          |   22 ++++
>  arch/powerpc/sysdev/Makefile             |    2 +-
>  arch/powerpc/sysdev/fsl_mpic_err.c       |  157
> ++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/mpic.c               |   95 +++++++++++++++----
>  arch/powerpc/sysdev/mpic.h               |   22 ++++
>  6 files changed, 338 insertions(+), 19 deletions(-)  create mode 100644
> arch/powerpc/sysdev/fsl_mpic_err.c
>=20
> --
> 1.7.2.2
