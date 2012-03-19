Return-Path: <r61911@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 489B8B6FE1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 13:50:39 +1100 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: fsl pci edac patches
Date: Mon, 19 Mar 2012 02:50:33 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020A9F83@039-SN2MPN1-013.039d.mgd.msft.net>
References: <31B0E63E-923D-4022-8B27-76CFF2189817@kernel.crashing.org>
 <CALT56yMXbaxJTGhL-8Hg3Dokc=Oi2qVKo912Q6uX3X8OErgB3w@mail.gmail.com>
In-Reply-To: <CALT56yMXbaxJTGhL-8Hg3Dokc=Oi2qVKo912Q6uX3X8OErgB3w@mail.gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, "linuxppc-dev@lists.ozlabs.org
 list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.or=
g]
> On Behalf Of Dmitry Eremin-Solenikov
> Sent: Sunday, March 18, 2012 1:11 AM
> To: Kumar Gala
> Cc: Lan Chunhe-B25806; linuxppc-dev@lists.ozlabs.org list
> Subject: Re: fsl pci edac patches
>=20
> Hello,
>=20
> On Sat, Mar 17, 2012 at 1:13 AM, Kumar Gala <galak@kernel.crashing.org>
> wrote:
> > Guys,
> >
> > I'm not sure what the state of the EDAC patches and latest kernel are..
> I'm going to mark the ones in patch works as 'dead' and hopefully you guy=
s
> will resend if there is still an interest.
>=20
> I don't have mpc85xx hardware to test at this point, so probably I
> don't care about 85xx EDAC binding right now.
> Strictly speaking I forgot about these patches :(
I do think the patch are still necessary, but need to update to new kernel =
base.
There are some 85xx pcie errata which need to be implemented in the EDAC co=
de.
Thanks.
Roy
