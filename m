Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0148.outbound.protection.outlook.com [65.55.169.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B7151A09EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 05:33:23 +1100 (AEDT)
Date: Thu, 2 Apr 2015 13:33:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [v8, 2/2] powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to
 device tree(s)
Message-ID: <20150402183308.GA8537@home.buserror.net>
References: <1427216109-13378-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1427216109-13378-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: devicetree@vger.kernel.org, Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Poonam
 Aggrwal <poonam.aggrwal@Freescale.com>, Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2015 at 11:55:09AM -0500, Emil Medve wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> [Emil Medve: Sync with the upstream binding]
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

This patch causes U-Boot to crash when doing device tree fixups, due to
the lack of cell-index.  Since we'd rather not break compatibility with
existing U-Boot (at least over something this trivial), I'll respin this
with cell-index, and add cell-index to the binding with a note that it's
only for U-Boot compatibility and is otherwise deprecated.

-Scott
