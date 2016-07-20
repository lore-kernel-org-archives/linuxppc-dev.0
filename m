Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvlqv0nvrzDqVQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 04:31:54 +1000 (AEST)
Message-ID: <1469039508.25630.17.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Yangbo Lu <yangbo.lu@nxp.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Wed, 20 Jul 2016 13:31:48 -0500
In-Reply-To: <4016699.uYaV8nWfqC@wuerfel>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <1468723822-30457-5-git-send-email-oss@buserror.net>
 <4016699.uYaV8nWfqC@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > 
> > From: yangbo lu <yangbo.lu@nxp.com>
> > 
> > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> > header file.  This SVR numberspace is used on some ARM chips as well as
> > PPC, and even to check for a PPC SVR multi-arch drivers would otherwise
> > need to ifdef the header inclusion and all references to the SVR symbols.
> > 
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > Acked-by: Joerg Roedel <jroedel@suse.de>
> > [scottwood: update description]
> > Signed-off-by: Scott Wood <oss@buserror.net>
> > 
> As discussed before, please don't introduce yet another vendor specific
> way to match a SoC ID from a device driver.
> 
> I've posted a patch for an extension to the soc_device infrastructure
> to allow comparing the running SoC to a table of devices, use that
> instead.

As I asked before, in which relevant maintainership capacity are you NACKing
this?

-Scott
