Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B6F61A003D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 08:42:54 +1000 (EST)
Message-ID: <1409784159.24184.127.camel@snotra.buserror.net>
Subject: Re: [PATCH] fsl-rio: add support for mapping inbound windows
From: Scott Wood <scottwood@freescale.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Date: Wed, 3 Sep 2014 17:42:39 -0500
In-Reply-To: <1407274663.7427.7.camel@snotra.buserror.net>
References: <1407246752-21639-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
 <1407274663.7427.7.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Alexandre.Bounine@idt.com, Liu Gang <Gang.Liu@freescale.com>,
 Barry.Wood@idt.com, linuxppc-dev@lists.ozlabs.org,
 stef.van.os@prodrive-technologies.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 16:37 -0500, Scott Wood wrote:
> On Tue, 2014-08-05 at 15:52 +0200, Martijn de Gouw wrote:
> > Add support for mapping and unmapping of inbound rapidio windows.
> > 
> > Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
> 
> Could you elaborate in the changelog on what this fixes or makes
> possible?  E.g. did the driver previously not support inbound
> transactions at all, or did it assume the window was set up by a
> bootloader?
> 
> Liu Gang, could you review this?

Liu Gang, ping?

-Scott
