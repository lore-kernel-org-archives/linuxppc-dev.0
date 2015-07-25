Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0140.outbound.protection.outlook.com [157.56.110.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CD1B1A035C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 12:24:50 +1000 (AEST)
Message-ID: <1437791076.2993.265.camel@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/85xx: add 'cpu-rev' property for cpus node
From: Scott Wood <scottwood@freescale.com>
To: Yangbo Lu <yangbo.lu@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
 <ulf.hansson@linaro.org>
Date: Fri, 24 Jul 2015 21:24:36 -0500
In-Reply-To: <1437471923-34172-1-git-send-email-yangbo.lu@freescale.com>
References: <1437471923-34172-1-git-send-email-yangbo.lu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-21 at 17:45 +0800, Yangbo Lu wrote:
> Add 'cpu-rev' property for cpus node to support getting cpu revision
> from dts, since it's not good to get cpu revision using powerpc specific
> function(like SVR_REV()) in common drivers.

No.  Don't modify the device tree within Linux without a really good reason 
(e.g. platform code to fix up a broken device tree).

Why not just read SVR from guts, which works on both PPC and ARM?

-Scott
