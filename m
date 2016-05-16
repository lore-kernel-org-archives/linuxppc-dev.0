Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7LjJ5hS8zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 10:21:08 +1000 (AEST)
Date: Sun, 15 May 2016 19:21:01 -0500
From: Scott Wood <oss@buserror.net>
To: Raghav Dogra <raghav@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, prabhakar.kushwaha@nxp.com
Message-ID: <20160516002101.GA2887@home.buserror.net>
References: <1454323598-5149-2-git-send-email-raghav@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454323598-5149-2-git-send-email-raghav@freescale.com>
Subject: Re: [2/3] driver/memory: Update dependency of IFC for Layerscape
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 01, 2016 at 04:16:37PM +0530, Raghav Dogra wrote:
> IFC NAND is not working on ARM layescape platform due to
> undefined macro FSL_SOC.
> This patch fixes the dependency to enable NAND.
> 
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> ---
>  drivers/memory/Kconfig   | 2 +-
>  drivers/memory/fsl_ifc.c | 4 +++-
>  drivers/mtd/nand/Kconfig | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)

Patches touching drivers/mtd need to CC the MTD list and maintainer.

-Scott
