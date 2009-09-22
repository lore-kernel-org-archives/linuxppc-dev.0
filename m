Return-Path: <phazarika@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ADB6BB7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 10:05:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] ibm_newemac: Add Support for MAL Interrupt Coalescing
Date: Mon, 21 Sep 2009 17:05:31 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D606FFE802@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1253576514.7103.165.camel@pasglop>
References: <1253573245-1867-1-git-send-email-phazarika@amcc.com>
	<1253576514.7103.165.camel@pasglop>
From: "Prodyut Hazarika" <phazarika@amcc.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: Victor Gallardo <vgallardo@amcc.com>, Feng Kan <fkan@amcc.com>,
	netdev@vger.kernel.org, lada.podivin@gmail.com,
	Loc Ho <lho@amcc.com>, bhutchings@solarflare.com,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,
Thanks again for your comments.

> Same goes with the SDR register definitions. Prefix them with the SOC
> name but don't make them conditionally compiled.

I will add the base address in the Device tree, and make all register
definitions based on offset from the base in the next version of this
patch.

> Also, this coalescing option, while it makes sense to have a CONFIG
> option to compile in the support for it or not, the choice to use
> coalescing or not should be done at runtime. Same goes with the
various
> thresholds which should be runtime configurable.

Thanks for this comment. I will hookup ethtool with the EMAC driver, but
the MAL driver will come up with default coalesce options (as defined in
the appropriate defconfig file). The user will be able to change these
parameters as needed using ethtool.

I will get all the changes in place in the next version of this patch.

Thanks
Prodyut
