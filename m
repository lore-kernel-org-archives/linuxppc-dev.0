Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 514E9B71A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2011 05:12:17 +1100 (EST)
Received: from mail131-ch1 (localhost [127.0.0.1])	by
 mail131-ch1-R.bigfish.com (Postfix) with ESMTP id 70543460362	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 18:12:38 +0000 (UTC)
Received: from CH1EHSMHS015.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail131-ch1.bigfish.com (Postfix) with ESMTP id
 4F7CB2003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 18:12:38 +0000 (UTC)
Message-ID: <4EF372F7.2040709@freescale.com>
Date: Thu, 22 Dec 2011 12:12:07 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v3 4/4] fsl_pmc: update device bindings
References: <1324554214-19502-1-git-send-email-chenhui.zhao@freescale.com>
 <1324554214-19502-4-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1324554214-19502-4-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/22/2011 05:43 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/pmc.txt        |   63 +++++++++++--------
>  1 files changed, 36 insertions(+), 27 deletions(-)

Pleace CC devicetree-discuss@lists.ozlabs.org on all changes to device
tree bindings.

-Scott
