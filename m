Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0103.outbound.protection.outlook.com [65.55.169.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79F4F1A0C18
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 09:02:08 +1100 (AEDT)
Message-ID: <1424728915.4698.8.camel@freescale.com>
Subject: Re: [PATCH][v3] powerpc/mpc85xx: Add FMan platform support
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Mon, 23 Feb 2015 16:01:55 -0600
In-Reply-To: <1424268285-8491-1-git-send-email-igal.liberman@freescale.com>
References: <1424268285-8491-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-18 at 16:04 +0200, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Get the FMan devices/sub-nodes (MAC, MDIO, etc.) auto-probed
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/common.c          |    1 +
>  arch/powerpc/platforms/85xx/corenet_generic.c |    3 +++
>  2 files changed, 4 insertions(+)

What changed from v2?

-Scott
