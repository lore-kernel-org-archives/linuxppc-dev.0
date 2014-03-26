Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5F7E14007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 05:14:09 +1100 (EST)
Message-ID: <1395857635.12738.35.camel@snotra.buserror.net>
Subject: Re: [PATCH] phy/at8031: enable at8031 to work on interrupt mode
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Wed, 26 Mar 2014 13:13:55 -0500
In-Reply-To: <1395816338-3090-1-git-send-email-B45475@freescale.com>
References: <1395816338-3090-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-26 at 14:45 +0800, Zhao Qiang wrote:
> The at8031 can work on polling mode and interrupt mode.
> Add ack_interrupt and config intr funcs to enable
> interrupt mode for it.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

This needs to go to the netdev maintainer/list.

-Scott
