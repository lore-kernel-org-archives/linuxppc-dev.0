Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9B9891007D9
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Oct 2011 09:23:24 +1100 (EST)
Message-ID: <4EA735E8.5010206@freescale.com>
Date: Tue, 25 Oct 2011 17:19:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 06/11] powerpc/85xx: Add ethernet magic packet property
 to P1020 device tree
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-4-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-5-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-6-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1319318452-27036-6-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/22/2011 04:20 PM, Kumar Gala wrote:
> All eTSEC2 controllers support waking on magic packet so fixup device
> tree to report that.

If they *all* support it, we can make the driver rely on the compatible
instead.

-Scott
