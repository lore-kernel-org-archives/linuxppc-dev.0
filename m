Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3EB9A2C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2013 09:02:11 +1100 (EST)
Date: Sat, 30 Mar 2013 23:01:53 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH 1/3] powerpc/512x: move mpc5121_generic platform to
 mpc512x_generic.
Message-ID: <20130330230153.6cff8a27@crub>
In-Reply-To: <1363801314-16967-2-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
 <1363801314-16967-2-git-send-email-matteo.facchinetti@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Mar 2013 18:41:52 +0100
Matteo Facchinetti <matteo.facchinetti@sirius-es.it> wrote:

> This provides a base for using 512x_generic platform on mpc5125 boards.
> 
> By this way 512x_GENERIC it could be used for all generic mpc512x boards
> and kernel could be compiled with mpc512x_defconfig.
> 
> Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> ---
>  arch/powerpc/configs/mpc512x_defconfig                         |    2 +-
>  arch/powerpc/platforms/512x/Kconfig                            |    8 ++++----
>  arch/powerpc/platforms/512x/Makefile                           |    2 +-
>  .../platforms/512x/{mpc5121_generic.c => mpc512x_generic.c}    |    0
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename arch/powerpc/platforms/512x/{mpc5121_generic.c => mpc512x_generic.c} (100%)

with a minor change to mpc512x_generic.c, applied to next.

Thanks,

Anatolij
