Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0B792C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 02:27:11 +1000 (EST)
Message-ID: <1378312019.12204.21.camel@snotra.buserror.net>
Subject: Re: [PATCH V3 1/2] powerpc/85xx: Add QE common init functions
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Date: Wed, 4 Sep 2013 11:26:59 -0500
In-Reply-To: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-02 at 18:11 +0800, Xie Xiaobo wrote:
> Define two QE init functions in common file, and avoid
> the same codes being duplicated in board files.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---
> V3 -> V2: Nochange
> 
>  arch/powerpc/platforms/85xx/common.c  | 47 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/mpc85xx.h |  8 ++++++
>  2 files changed, 55 insertions(+)

Don't just copy it; remove it from the place you copied from and have
that code call the common version.

-Scott
