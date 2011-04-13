Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFD72B7204
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 14:40:51 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Felix Radensky <felix@embedded-sol.com>, "linuxppc-dev@ozlabs.org"
	<linuxppc-dev@ozlabs.org>
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
Date: Wed, 13 Apr 2011 04:40:44 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F87417330E@039-SN1MPN1-004.039d.mgd.msft.net>
References: <470DB7CE2CD0944E9436E7ADEFC02FE314BF85@039-SN1MPN1-001.039d.mgd.msft.net>
In-Reply-To: <470DB7CE2CD0944E9436E7ADEFC02FE314BF85@039-SN1MPN1-001.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gupta Maneesh-B18878 <B18878@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Felix,

> -----Original Message-----
> From: linuxppc-dev-bounces+priyanka.jain=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+priyanka.jain=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Feli=
x
> Radensky
> Sent: Tuesday, April 12, 2011 10:24 AM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@ozlabs.org; Gupta Maneesh-B18878; Kushwaha Prabhakar-
> B32579
> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>=20
> Hi Poonam
>=20
> On 04/12/2011 07:05 AM, Aggrwal Poonam-B10812 wrote:
> > Hello Felix
> >
> > Please find some comments inline.
> >
> > Regards
> > Poonam
> >
> >> -----Original Message-----
> >> From: Kushwaha Prabhakar-B32579
> >> Sent: Tuesday, April 12, 2011 9:26 AM
> >> To: Aggrwal Poonam-B10812
> >> Subject: FW: Problem with mini-PCI-E slot on P2020RDB
> >>
> >>
> >>
> >> -----Original Message-----
> >> From: Felix Radensky [mailto:felix@embedded-sol.com]
> >> Sent: Monday, April 11, 2011 7:16 PM
> >> To: Kushwaha Prabhakar-B32579
> >> Cc: Fabian Bertholm; Leon Woestenberg; linuxppc-dev@ozlabs.org;
> >> Mahajan Vivek-B08308; Aggrwal Poonam-B10812; Gupta Maneesh-B18878
> >> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
> >>
> >> Hi Prabhakar,
> >>
> >> On 04/11/2011 02:09 PM, Kushwaha Prabhakar-B32579 wrote:
> >>> Hi,
> >>>
> >>> Yes. It wil be applicable for all revisions.
> >>>
> >>> Regards,
> >>> Prabhakar
> >>>
> >> I'm sure this is applicable to all revisions, but it doesn't
> >> necessarily makes things work. The problem I've reported back in 2009
> >> still exists on P2020RDB revC, even if I use the latest u-boot and
> >> kernel and make device tree changes that you've suggested.
> >> I've attached the boot log.
> > As such there is no hardware fix related to this issue between RevC to
> RevD. The solution was a software patch to resolve the issue related to
> IRQ0.
>=20
> Are you sure ? Please take a look at Freescale document titled
> "P1020E/P2020E RDB System Errata".
> There's errata CE10, IRQ0 held low. It is fixed in Rev D. Vivek Mahajan,
> who looked at the issue back in 2009, estimated that problem can be
> related to missing pull-up on IRQ0. This is exactly what is fixed in Rev
> D.
>=20

We are looking into it and are in discussion with design team.

We will keep you posted for the same..

--Prabhakar
