Return-Path: <B16395@freescale.com>
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 4/4] powerpc/mpic: FSL MPIC error interrupt support.
Date: Fri, 6 Jul 2012 04:02:44 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D12D9E5@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1332850633-23661-1-git-send-email-Varun.Sethi@freescale.com>
 <7F9EFF8D-82E4-414E-BB76-24BE84F2D8BC@kernel.crashing.org>
 <4F720FE3.7080101@freescale.com>
 <7376AC30-8A8F-4A3E-A025-C8F92AFE23E5@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D11E1F1@039-SN2MPN1-012.039d.mgd.msft.net>
 <4FDF7EBC.8090604@freescale.com>
 <C5ECD7A89D1DC44195F34B25E172658D11E224@039-SN2MPN1-012.039d.mgd.msft.net>
 <4FDF8031.3090705@freescale.com>
In-Reply-To: <4FDF8031.3090705@freescale.com>
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



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, June 19, 2012 12:53 AM
> To: Sethi Varun-B16395
> Cc: Wood Scott-B07421; Kumar Gala; Linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 4/4] powerpc/mpic: FSL MPIC error interrupt support.
>=20
> On 06/18/2012 02:19 PM, Sethi Varun-B16395 wrote:
> >
> >
> >> -----Original Message-----
> >> From: Wood Scott-B07421
> >> Sent: Tuesday, June 19, 2012 12:47 AM
> >> To: Sethi Varun-B16395
> >> Cc: Kumar Gala; Wood Scott-B07421; Linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [PATCH 4/4] powerpc/mpic: FSL MPIC error interrupt
> support.
> >>
> >> On 06/18/2012 02:12 PM, Sethi Varun-B16395 wrote:
> >>>
> >>>
> >>>>>> +/*
> >>>>>>> + * Error interrupt registers
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +#define MPIC_ERR_INT_BASE	0x3900
> >>>>>>> +#define MPIC_ERR_INT_EISR	0x0000
> >>>>>>> +#define MPIC_ERR_INT_EIMR	0x0010
> >>>>>>> +
> >>>>>>> #define MPIC_MAX_IRQ_SOURCES	2048
> >>>>>>> #define MPIC_MAX_CPUS		32
> >>>>>>> #define MPIC_MAX_ISU		32
> >>>>>>>
> >>>>>>> #define MPIC_MAX_TIMER    8
> >>>>>>> #define MPIC_MAX_IPI      4
> >>>>>>> +#define MPIC_MAX_ERR      32
> >>>>>>
> >>>>>> Should probably be 64
> >>>>>
> >>>>> This patch supports MPIC 4.1 and EISR0.  When support is added for
> >>>>> EISR1 (didn't realize this was coming until your comment prompted
> >>>>> me to check...), this should be updated, but this change alone
> >>>>> would not make it work.
> >>>>
> >>>> Would prefer we handle this now rather than later (T4240 is going
> >>>> to need
> >>>> EISR1 support).
> >>> Hi Kumar,
> >>> As of now I don't have a proper mechanism to test this functionality.
> >>> I will submit a follow up patch for EISR1/EIMR1 support once I have
> >>> a mechanism to test this functionality.
> >>
> >> You could still write the code in a way that scales to multiple
> >> EISRs, and test that it works with EISR0.
> >>
> > Yes, but I would like to submit the patch once I have tested it.
>=20
> So test it the way I described, and submit. :-P
There just seem to be 32 error interrupts even in case of T4240, that means=
 there is no
need to handle multiple EISRs.

I have already submitted a revised patch for handling MPIC error interrupts=
.
[PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt support

-Varun
