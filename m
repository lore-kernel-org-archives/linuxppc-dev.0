Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B3831A1D03
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 01:32:40 +1000 (AEST)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Mike Turquette
 <mturquette@linaro.org>, Yuantian Tang <Yuantian.Tang@freescale.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: RE: [RFC PATCH 8/8] powerpc/fsl: Use new clockgen binding
Date: Thu, 30 Jul 2015 15:32:32 +0000
Message-ID: <DM2PR03MB50986F3471DF3DD74494002E68B0@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <1434682158-7243-9-git-send-email-scottwood@freescale.com>
In-Reply-To: <1434682158-7243-9-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Regards,
Igal Liberman.

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, June 19, 2015 5:49 AM
> To: Mike Turquette; Tang Yuantian-B29983
> Cc: Rafael J. Wysocki; Liberman Igal-B31950; Bucur Madalin-Cristian-B3271=
6;
> linux-clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Wood Scott-B07421
> Subject: [RFC PATCH 8/8] powerpc/fsl: Use new clockgen binding
>=20
> The driver retains compatibility with old device trees, but we don't want=
 the
> old nodes lying around to be copied, or used as a reference (some of the
> mux options are incorrect), or even just being clutter.
>=20
> We will also need the #clock-cells in the clockgen node in order to add f=
man
> nodes.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Tested on: several e500mc, e5500 and e6500 platforms.

Tested-by: Igal Liberman <Igal.Liberman@freescale.com>
