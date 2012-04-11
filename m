Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42A0CB7062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 19:07:10 +1000 (EST)
Date: Wed, 11 Apr 2012 11:06:57 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] powerpc: 512x: Fix mpc5121_clk_get()
Message-ID: <20120411110657.1deaad93@wker>
In-Reply-To: <1332788489-27435-1-git-send-email-richard@nod.at>
References: <1332788489-27435-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 26 Mar 2012 21:01:29 +0200
Richard Weinberger <richard@nod.at> wrote:

> If try_module_get() fails, mpc5121_clk_get() might return
> a wrong clock.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/powerpc/platforms/512x/clock.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

Anatolij
