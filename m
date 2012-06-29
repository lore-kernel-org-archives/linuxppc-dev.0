Return-Path: <r61911@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42A5C100B14
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 02:07:05 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Jia Hongtao-B38951
 <B38951@freescale.com>
Subject: RE: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
 platform
Date: Fri, 29 Jun 2012 16:06:38 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002079A7013@039-SN2MPN1-011.039d.mgd.msft.net>
References: <20120627234851.GA9071@tyr.buserror.net>
 <412C8208B4A0464FA894C5F0C278CD5D01A10EAB@039-SN1MPN1-002.039d.mgd.msft.net>
 <4FEC86CC.90307@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A13620@039-SN1MPN1-002.039d.mgd.msft.net>
 <34D617F2-54CD-46DA-A110-E44CE081B99B@kernel.crashing.org>
In-Reply-To: <34D617F2-54CD-46DA-A110-E44CE081B99B@kernel.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, "agraf@suse.de" <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Kumar Gala
> Sent: Friday, June 29, 2012 23:58 PM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Li Yang-R58472;
> agraf@suse.de
> Subject: Re: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
> platform
>=20
>=20
> On Jun 28, 2012, at 9:36 PM, Jia Hongtao-B38951 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Wood Scott-B07421
> >> Sent: Friday, June 29, 2012 12:31 AM
> >> To: Jia Hongtao-B38951
> >> Cc: Wood Scott-B07421; galak@kernel.crashing.org; Li Yang-R58472;
> >> agraf@suse.de; linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravir=
t
> >> platform
> >>
> >> On 06/27/2012 11:06 PM, Jia Hongtao-B38951 wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Wood Scott-B07421
> >>>> Sent: Thursday, June 28, 2012 7:49 AM
> >>>> To: galak@kernel.crashing.org
> >>>> Cc: agraf@suse.de; linuxppc-dev@lists.ozlabs.org; Jia Hongtao-B38951
> >>>> Subject: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
> >>>> platform
> >>>>
> >>>> The QEMU stuff is related to the PCI refactoring because currently
> >>>> we have a hard time selecting a primary bus under QEMU, and also
> >> because
> >>>> the generic qemu e500 platform wants a full list of FSL PCI
> >> compatibles
> >>>> to check.
> >>>>
> >>>
> >>> It seems that not all primary bus has "isa" node like 8541 and 8555.
> >>
> >> Do those boards (it's the boards that matter, not chips...) have legac=
y
> >> ISA?  If they do, and it's not in the device tree, then we should fix
> >> the device tree for consistency, but also retain some sort of hack to
> >> remain compatible with old device trees.
> >>
> >> A board can refrain from using the new common infrastructure if it has=
 a
> >> good reason to.
> >
> > I'm not sure that MPC8541CDS (or 8555) has legacy ISA. I just checked i=
n
> > kernel and dts which implies the board has primary bus and no "isa" nod=
e.
> > I will find out the facts later.
>=20
> Pretty sure the boards have ISA, if you see the .dts has references to 'I=
SA
> bridge' & 'i8259' PIC.
It is on the VIA south bridge.
Roy
