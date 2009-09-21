Return-Path: <phazarika@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DE451B7B71
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 09:49:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] ibm_newemac: Add Support for MAL Interrupt Coalescing
Date: Mon, 21 Sep 2009 16:49:26 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D606FFE7FF@SDCEXCHANGE01.ad.amcc.com>
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
Thanks for your comments.


> What happens if we build a kernel that is supposed to boot with two
> different variants of 405 or 440 ?

We cannot build a kernel with H/W Interrupt coalescing other than in
405EX/460EX/GT.
This is controlled via KConfig (config IBM_NEW_EMAC_INTR_COALESCE
depends on IBM_NEW_EMAC && (460EX || 460GT || 405EX))
Is this approach acceptable (via Kconfig)?


> There are existing mechanisms via ethtool to configure coalescing. You
> should hookup onto these.

I will start looking at the ethtool options

Thanks
Prodyut
