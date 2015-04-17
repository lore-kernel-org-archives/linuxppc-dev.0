Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0129.outbound.protection.outlook.com [207.46.100.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B3821A0D66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 15:42:37 +1000 (AEST)
Message-ID: <1429249343.32545.53.camel@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Move pll0/1-div4 index
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Fri, 17 Apr 2015 00:42:23 -0500
In-Reply-To: <1429186105-6991-1-git-send-email-igal.liberman@freescale.com>
References: <1429186105-6991-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-16 at 15:08 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> This patch updates pll0/1-div4 index to '3'.
> Originally it was '2'.
> 
> The following patch adds pll0/1-div3 option:
> 	https://patchwork.ozlabs.org/patch/461151/
> After this patch, index '2' becomes pll0/1-div3.
> 
> This patch based on top of the following:
> 	https://patchwork.ozlabs.org/patch/461811/
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>

This needs to be done in the same patch as the provider change, to avoid
a buggy intermediate state.

Will there be a new binding patch coming?

-Scott
