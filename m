Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11F871A0272
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 23:29:35 +1100 (AEDT)
Date: Thu, 22 Oct 2015 14:24:02 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, jack@suse.cz, neilb@suse.com,
 axboe@fb.com, paulus@samba.org, matthew.r.wilcox@intel.com, Luis de
 Bethencourt <luis@debethencourt.com>, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, ross.zwisler@linux.intel.com
Subject: Re: [RESEND PATCH 1/2] powerpc: platforms: mpc52xx_lpbfifo: Fix
 module autoload for OF platform driver
Message-ID: <20151022142402.37bb940d@crub>
In-Reply-To: <1445353453-846-2-git-send-email-luisbg@osg.samsung.com>
References: <1445353453-846-1-git-send-email-luisbg@osg.samsung.com>
 <1445353453-846-2-git-send-email-luisbg@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Oct 2015 16:04:12 +0100
Luis de Bethencourt <luisbg@osg.samsung.com> wrote:

> From: Luis de Bethencourt <luis@debethencourt.com>
> 
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 1 +
>  1 file changed, 1 insertion(+)

applied to mpc5xxx/next.

Thanks,

Anatolij
