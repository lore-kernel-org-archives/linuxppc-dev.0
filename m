Return-Path: <B32579@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D308B6F82
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 18:31:44 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: RE: known working sata_sil24.c setup on powerpc platforms?
Date: Fri, 8 Apr 2011 08:31:25 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F87416D8CC@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
	<4D9CAD1F.6060500@garzik.org>
	<BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416BDD0@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTin1KoJ8EsV49naEAZjmq=EZLHXZpQ@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D3E7@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTi=jLZrS+rOBOMq=v3aMCPjNAUjS4w@mail.gmail.com>
In-Reply-To: <BANLkTi=jLZrS+rOBOMq=v3aMCPjNAUjS4w@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	Linux PPC <linuxppc-dev@ozlabs.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>,
	Gupta Maneesh-B18878 <B18878@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leon,


> -----Original Message-----
> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
> Sent: Friday, April 08, 2011 1:55 PM
> To: Kushwaha Prabhakar-B32579
> Cc: Moffett, Kyle D; linux-ide@vger.kernel.org; Tejun Heo; Jeff Garzik;
> Linux PPC; Gupta Maneesh-B18878
> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>=20
> Hello Prabhakar,
>=20
> On Fri, Apr 8, 2011 at 5:44 AM, Kushwaha Prabhakar-B32579
> <B32579@freescale.com> wrote:
> >> -----Original Message-----
> >> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
> >> owner@vger.kernel.org] On Behalf Of Leon Woestenberg
> >> Sent: Thursday, April 07, 2011 10:23 PM
> >> To: Kushwaha Prabhakar-B32579
> >> Cc: Moffett, Kyle D; Linux PPC; linux-ide@vger.kernel.org; Tejun Heo;
> >> Jeff Garzik
> >> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
> >>
> >> On Thu, Apr 7, 2011 at 6:48 AM, Kushwaha Prabhakar-B32579
> >> <B32579@freescale.com> wrote:
> >> > Can you please check p2020rdb.dts for IDSEL entries for pci0/1 node?
> >> >
> >> > In order to work in legacy mode, IDSEL entries are required.
> >> >
> >> No, the p1020rdb and p2020rdb do not have the IDSEL entries:
> >> What would the correct IDSEL entries be?
> >
> > For legacy interrupt to work IDSEL values are required.. please find
> the correct IDSEL values for pci0/1.
> >
> > =A0 =A0 =A0 =A0pci0: pcie@ffe09000 {
> > ...
> > Please try with this.. I am in process of pushing these IDSEL values to
> upstream.
> >
>=20
> Do you have these for P1020RDB  as well? I found a P1020RDB board that
> has the CE10 errata fixed, so IRQ0 is properly pulled up.
>=20

  Same IDSEL values are valid for P1020RDB also.

--Prabhakar
