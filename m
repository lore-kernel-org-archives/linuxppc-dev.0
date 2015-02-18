Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 715271A014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 05:04:43 +1100 (AEDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC v2 00/10] Freescale DPAA B/QMan drivers
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
Date: Wed, 18 Feb 2015 11:45:42 -0600
Message-Id: <E1A56F73-3896-4644-B001-F014D95D507A@kernel.crashing.org>
References: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 16, 2015, at 9:46 AM, Emil Medve <Emilian.Medve@freescale.com> =
wrote:

> v2:	Moved out of staging into soc/freescale
>=20
> Hello,
>=20
>=20
> This is the se attempt to publish the . They are
> not to be applied yet. =20
>=20
> These are the Freescale DPAA B/QMan drivers. At this stage, this is =
more or less
> the drivers from the Freescale PowerPC SDK roughly squashed and split =
in a
> sequence of component patches. They still needs some work and cleanup =
before we
> expect to have them applied, but we appreciate early feedback
>=20
> To do:	Add a maintainer(s) entry
> 	Add module(s) support
> 	Some important clean-ups
>=20
> Cheers,
>=20
>=20
> Geoff Thorpe (8):
>  fsl_bman: Add drivers for the Freescale DPAA BMan
>  fsl_qman: Add drivers for the Freescale DPAA QMan
>  powerpc/mpc85xx: Add platform support for the Freescale DPAA BMan
>  powerpc/mpc85xx: Add platform support for the Freescale DPAA QMan
>  fsl_bman: Add self-tester
>  fsl_qman: Add self-tester
>  fsl_bman: Add debugfs support
>  fsl_qman: Add debugfs support
>=20
> Hai-Ying Wang (2):
>  fsl_bman: Add HOTPLUG_CPU support
>  fsl_qman: Add HOTPLUG_CPU support

Really should look at using CMA for memory reservations used by q/bman =
backing store.

- k=
