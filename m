Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98A411A06D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 07:22:04 +1000 (EST)
Message-ID: <1401484910.6603.218.camel@snotra.buserror.net>
Subject: Re: [PATCH] t4240/dts: Enable third elo3 DMA engine support
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Date: Fri, 30 May 2014 16:21:50 -0500
In-Reply-To: <1401266854-31088-1-git-send-email-Chunhe.Lan@freescale.com>
References: <1401266854-31088-1-git-send-email-Chunhe.Lan@freescale.com>
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

On Wed, 2014-05-28 at 16:47 +0800, Chunhe Lan wrote:
> T4240QDS and T4240RDB have the third DMA engine
> controller. So add corresponding DMA node into
> dts file.

s/T4240QDS and T4240RDB have/T4240 has/ -- the board is irrelevant.

I'll fix when applying.

-Scott
