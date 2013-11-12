Return-Path: <scottwood@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C2A02C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 08:58:20 +1100 (EST)
Message-ID: <1384293487.1403.67.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/4] phylib: Add Clause 45 read/write functions
From: Scott Wood <scottwood@freescale.com>
To: <shh.xie@gmail.com>
Date: Tue, 12 Nov 2013 15:58:07 -0600
In-Reply-To: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
References: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Shruti@freescale.com, madalin.bucur@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-11-11 at 19:04 +0800, shh.xie@gmail.com wrote:
> From: Andy Fleming
> 
> You need an extra parameter to read or write Clause 45 PHYs, so
> we need a different API with the extra parameter.
> 
> Signed-off-by: Andy Fleming
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>

Why did you remove Andy's e-mail address?  Even though it's no longer
valid, it helps identify which specific person you're talking about.

-Scott
