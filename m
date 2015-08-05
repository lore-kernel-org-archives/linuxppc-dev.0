Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0131.outbound.protection.outlook.com [207.46.100.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 436951A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 10:19:02 +1000 (AEST)
Date: Tue, 4 Aug 2015 19:18:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: shaohui xie <shh.xie@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [1/2] powerpc/config: enable teranetics PHY
Message-ID: <20150805001848.GA2861@home.buserror.net>
References: <1437709533-26452-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1437709533-26452-1-git-send-email-shh.xie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 24, 2015 at 11:45:33AM +0800, shaohui xie wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
> 
> The PHY uses XAUI interface to connect to MAC, mostly the PHY used on
> riser card.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
>  arch/powerpc/configs/corenet32_smp_defconfig | 1 +
>  arch/powerpc/configs/corenet64_smp_defconfig | 1 +
>  2 files changed, 2 insertions(+)

Next time, please use a subject line that lets me know that this is a
patch that I'd be picking up, such as "powerpc/85xx: ..." or
"powerpc/corenet: ..."

-Scott
