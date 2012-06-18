Return-Path: <B16395@freescale.com>
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 4/4] powerpc/mpic: FSL MPIC error interrupt support.
Date: Mon, 18 Jun 2012 19:12:30 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D11E1F1@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1332850633-23661-1-git-send-email-Varun.Sethi@freescale.com>
 <7F9EFF8D-82E4-414E-BB76-24BE84F2D8BC@kernel.crashing.org>
 <4F720FE3.7080101@freescale.com>
 <7376AC30-8A8F-4A3E-A025-C8F92AFE23E5@kernel.crashing.org>
In-Reply-To: <7376AC30-8A8F-4A3E-A025-C8F92AFE23E5@kernel.crashing.org>
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



>>> +/*
> >>> + * Error interrupt registers
> >>> + */
> >>> +
> >>> +#define MPIC_ERR_INT_BASE	0x3900
> >>> +#define MPIC_ERR_INT_EISR	0x0000
> >>> +#define MPIC_ERR_INT_EIMR	0x0010
> >>> +
> >>> #define MPIC_MAX_IRQ_SOURCES	2048
> >>> #define MPIC_MAX_CPUS		32
> >>> #define MPIC_MAX_ISU		32
> >>>
> >>> #define MPIC_MAX_TIMER    8
> >>> #define MPIC_MAX_IPI      4
> >>> +#define MPIC_MAX_ERR      32
> >>
> >> Should probably be 64
> >
> > This patch supports MPIC 4.1 and EISR0.  When support is added for
> > EISR1 (didn't realize this was coming until your comment prompted me
> > to check...), this should be updated, but this change alone would not
> > make it work.
>=20
> Would prefer we handle this now rather than later (T4240 is going to need
> EISR1 support).
Hi Kumar,
As of now I don't have a proper mechanism to test this functionality. I wil=
l
submit a follow up patch for EISR1/EIMR1 support once I have a mechanism to
test this functionality.

Regards
Varun
=20
