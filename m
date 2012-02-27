Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C037CB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 06:19:26 +1100 (EST)
Message-ID: <4F4BD726.1030805@freescale.com>
Date: Mon, 27 Feb 2012 13:19:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olivia Yin <hong-hua.yin@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/e500: make load_up_spe a normal fuction
References: <1330340388-30296-1-git-send-email-hong-hua.yin@freescale.com>
In-Reply-To: <1330340388-30296-1-git-send-email-hong-hua.yin@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Liu Yu <yu.liu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/27/2012 04:59 AM, Olivia Yin wrote:
> So that we can call it in kernel.
> 
> Signed-off-by: Liu Yu <yu.liu@freescale.com>

Explain why we want this, and point out that this makes it similar to
load_up_fpu.

> ---
>  arch/powerpc/kernel/head_fsl_booke.S |   23 ++++++-----------------
>  1 files changed, 6 insertions(+), 17 deletions(-)

When posting a patch authored by someone else, more or less unchanged,
you should put a From: line in the body of the e-mail.

git send-email will do this automatically if you preserve the authorship
in the git commit.

Also, you should add your own Signed-off-by.

-Scott
