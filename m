Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AA24B6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2012 05:43:59 +1000 (EST)
Message-ID: <4F99A575.2050700@freescale.com>
Date: Thu, 26 Apr 2012 14:43:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH v2] powerpc/85xx: Enable MTD/NOR/NAND options by default
 in defconfig
References: <1335436983-21360-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1335436983-21360-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/26/2012 05:43 AM, Shengzhou Liu wrote:
> +CONFIG_MTD_NAND_VERIFY_WRITE=y

I don't think we want this on by default.

-Scott
