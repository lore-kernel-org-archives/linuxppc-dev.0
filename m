Return-Path: <B11780@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 05513B72F6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 05:00:44 +1100 (EST)
Received: from mail52-db3 (localhost.localdomain [127.0.0.1])	by
 mail52-db3-R.bigfish.com (Postfix) with ESMTP id 8C7A91188452	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 18:00:31 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.242])	by
 mail52-db3.bigfish.com (Postfix) with ESMTP id 1490DE30050	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 18:00:30 +0000 (UTC)
Subject: Re: [PATCH 3/5] powerpc/85xx: Make kexec to interate over online cpus
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1319583246-6120-3-git-send-email-msm@freescale.com>
Date: Thu, 3 Nov 2011 13:00:32 -0500
Message-ID: <3B689200-F6FF-47E7-9C4B-2C26C980EF27@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
 <1319583246-6120-3-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 25, 2011, at 5:54 PM, Matthew McClintock wrote:

> This is not strictly required, because this iterates over logical
> cpus and they are not (currently) discontigous. But, it's cleaner
> code and more obvious what is going on
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied

- k
