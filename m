Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0127.outbound.protection.outlook.com [65.55.169.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FA0C1A0894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 12:35:42 +1000 (AEST)
Message-ID: <1438137329.2993.328.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-pci: fix pcie range issue for some P1/P2
 boards
From: Scott Wood <scottwood@freescale.com>
To: Hou Zhiqiang-B48286 <B48286@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Hu
 Mingkai-B21284" <Mingkai.Hu@freescale.com>
Date: Tue, 28 Jul 2015 21:35:29 -0500
In-Reply-To: <CY1PR0301MB0780D3C72FF1F86DE25345CE8B8C0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1437559704-13332-1-git-send-email-B48286@freescale.com>
 <1437792504.2993.280.camel@freescale.com>
 <CY1PR0301MB0780D3C72FF1F86DE25345CE8B8C0@CY1PR0301MB0780.namprd03.prod.outlook.com>
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

On Tue, 2015-07-28 at 21:34 -0500, Hou Zhiqiang-B48286 wrote:
> Hi Scott and all,
> 
> Please ignore this patch!

Did you figure out what was actually causing you to see CPU stalls?

-Scott
