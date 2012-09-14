Return-Path: <sruffell@digium.com>
Received: from mail.digium.com (mail.digium.com [216.207.245.2])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AFB8E2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2012 04:47:30 +1000 (EST)
Date: Fri, 14 Sep 2012 13:21:37 -0500
From: Shaun Ruffell <sruffell@digium.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH] edac/85xx: fix error handle of mpc85xx_mc_err_probe
Message-ID: <20120914182137.GD18672@digium.com>
References: <1347533729-5893-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347533729-5893-1-git-send-email-Shaohui.Xie@freescale.com>
Cc: avorontsov@mvista.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-edac@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2012 at 06:55:29PM +0800, Shaohui Xie wrote:
> Error handle in case of DDR ECC off is wrong, sysfs entries have not been
> created, so edac_mc_free which frees a mci instance should not be called.
> Also, free mci's memory in this case.

Jus FYI: I ran into the same error in edac_mc_free() which I
resolved in a slightly different way in some patches I sent
previously. [1]

[1] https://lkml.org/lkml/2012/9/14/475 

Cheers,
Shaun
