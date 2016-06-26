Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rd3Fk57TrzDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 06:14:50 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Proposed: Patch to fix boot on PA6T
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
Date: Sun, 26 Jun 2016 21:08:37 +0100
Cc: linuxppc-dev@lists.ozlabs.org, matthew@a-eon.com,
 Pat Wall <pjwall@mac.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 aperez@alexperez.com
Message-Id: <00D9B9A8-964A-4B96-9A44-DFC8E9F5BFDB@xenosoft.de>
References: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Darren,

Fantastic news! I'll test your patch with the RC5 tomorrow. Excellent work! W=
ell done!

- Christian

Sent from my iPhone

> On 26 Jun 2016, at 18:42, Darren Stevens <darren@stevens-zone.net> wrote:
>=20
> Hello All,
>=20
>    commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
>    powerpc/mm: vmalloc abstraction in preparation for radix
>=20
>    This commit introduced variables for some linux kernel addresses that h=
ad
> before
>    been constants, unfortunately this stopped PaSemi PA6T systems(*) from
> booting as
>    they call ioremap to map SoC registers before the mmu is initialised. T=
he
> attached
>    patch adds a hard-coded init of pci_io_base to the pas_init_early()
> function which
>    which allows the kernel to boot normally.
>=20
>    The value will be harmlessly set again once pci starts up.
>=20
>    (*) At the moment this has only been tested on an AmigaOneX1000, but I
> expect PaSemi
>    reference systems to have been affected in the same way.
>=20
> Kind regards
> Darren
> <pa6t-bootfix.patch>
