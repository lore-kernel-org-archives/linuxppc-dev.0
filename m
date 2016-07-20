Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvZLd6GQPzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 21:24:24 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, Yangbo Lu <yangbo.lu@nxp.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Wed, 20 Jul 2016 13:24:00 +0200
Message-ID: <4016699.uYaV8nWfqC@wuerfel>
In-Reply-To: <1468723822-30457-5-git-send-email-oss@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <1468723822-30457-5-git-send-email-oss@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> From: yangbo lu <yangbo.lu@nxp.com>
> 
> Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> header file.  This SVR numberspace is used on some ARM chips as well as
> PPC, and even to check for a PPC SVR multi-arch drivers would otherwise
> need to ifdef the header inclusion and all references to the SVR symbols.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> [scottwood: update description]
> Signed-off-by: Scott Wood <oss@buserror.net>
> 

As discussed before, please don't introduce yet another vendor specific
way to match a SoC ID from a device driver.

I've posted a patch for an extension to the soc_device infrastructure
to allow comparing the running SoC to a table of devices, use that
instead.

	Arnd
