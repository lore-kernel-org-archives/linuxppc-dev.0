Return-Path: <B11780@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 30E3EB7249
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 05:00:38 +1100 (EST)
Received: from mail16-am1 (localhost.localdomain [127.0.0.1])	by
 mail16-am1-R.bigfish.com (Postfix) with ESMTP id 1C9398183A3	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 18:00:26 +0000 (UTC)
Received: from AM1EHSMHS015.bigfish.com (unknown [10.3.201.254])	by
 mail16-am1.bigfish.com (Postfix) with ESMTP id AD48B18F8051	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 18:00:24 +0000 (UTC)
Subject: Re: [PATCH 2/5] powerpc/fsl_booke: Fix comment in head_fsl_booke.S
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1319583246-6120-2-git-send-email-msm@freescale.com>
Date: Thu, 3 Nov 2011 13:00:26 -0500
Message-ID: <82810F69-D5BB-438A-B052-27D1977317C9@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
 <1319583246-6120-2-git-send-email-msm@freescale.com>
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

> Fix typo in comments introduced by:
> 
> commit 6dece0eb69b2a28e18d104bc5d707f1cb673f5e0
> Author: Scott Wood <scottwood@freescale.com>
> Date:   Mon Jul 25 11:29:33 2011 +0000
> 
>    powerpc/32: Pass device tree address as u64 to machine_init
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> cc: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied

- k
