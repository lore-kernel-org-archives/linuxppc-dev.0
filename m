Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F1FA1A0318
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 11:00:56 +1000 (AEST)
Date: Thu, 1 Oct 2015 20:00:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Madalin Bucur <madalin.bucur@freescale.com>
CC: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
 <igal.liberman@freescale.com>, <roy.pledge@freescale.com>,
 <ppc@mindchasers.com>, <joe@perches.com>, <pebolle@tiscali.nl>,
 <joakim.tjernlund@transmode.se>, <f.fainelli@gmail.com>, <stsp@list.ru>
Subject: Re: [v3 1/8] devres: add devm_alloc_percpu()
Message-ID: <20151002010041.GA4245@home.buserror.net>
References: <1443106819-5549-1-git-send-email-madalin.bucur@freescale.com>
 <1443106819-5549-2-git-send-email-madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1443106819-5549-2-git-send-email-madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2015 at 06:00:12PM +0300, Madalin Bucur wrote:
> Introduce managed counterparts for alloc_percpu() and free_percpu().
> Add devm_alloc_percpu() and devm_free_percpu() into the managed
> interfaces list.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> Tested-by: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
> ---
>  Documentation/driver-model/devres.txt |  4 +++
>  drivers/base/devres.c                 | 64 +++++++++++++++++++++++++++++++++++
>  include/linux/device.h                | 19 +++++++++++
>  3 files changed, 87 insertions(+)

Greg KH needs to be CCed on any drivers/base changes.

-Scott
