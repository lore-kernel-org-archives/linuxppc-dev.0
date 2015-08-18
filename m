Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0110.outbound.protection.outlook.com [65.55.169.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73EC51A0239
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 01:46:09 +1000 (AEST)
Message-ID: <1439912743.2784.0.camel@freescale.com>
Subject: Re: [PATCH V2] powerpc/85xx: Remove unused pci fixup hooks on c293pcie
From: Scott Wood <scottwood@freescale.com>
To: Hou Zhiqiang-B48286 <B48286@freescale.com>
CC: "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Hu
 Mingkai-B21284" <Mingkai.Hu@freescale.com>, Wang Dongsheng-B40534
 <Dongsheng.Wang@freescale.com>
Date: Tue, 18 Aug 2015 10:45:43 -0500
In-Reply-To: <CY1PR0301MB0780D0F57AED04231C73C3438B780@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1439199585-37464-1-git-send-email-B48286@freescale.com>
 <CY1PR0301MB0780D0F57AED04231C73C3438B780@CY1PR0301MB0780.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-18 at 04:26 -0500, Hou Zhiqiang-B48286 wrote:
> Hi Scott,
> 
> Removed both pcibios_fixup_phb and pcibios_fixup_bus.
> Could you please help to apply it?

I applied it and sent a pull request yesterday.

-Scott
