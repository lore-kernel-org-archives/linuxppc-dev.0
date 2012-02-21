Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C76CFB6FA5
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2012 09:00:12 +1100 (EST)
Message-ID: <4F44134E.1070802@freescale.com>
Date: Tue, 21 Feb 2012 15:57:34 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v5 4/4] KVM: PPC: epapr: Update other hypercall invoking
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-2-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-4-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329799573-8820-4-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, B07421@freescale.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2012 10:46 PM, Liu Yu wrote:
> Discard the old way that invoke hypercall,
> instead, use epapr paravirt.
> 
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v5: new patch
> 
>  arch/powerpc/include/asm/epapr_hcalls.h |   22 +++++++++---------
>  arch/powerpc/include/asm/fsl_hcalls.h   |   36 +++++++++++++++---------------
>  2 files changed, 29 insertions(+), 29 deletions(-)

Make sure all the Topaz/ePAPR drivers that use this select EPAPR_PARAVIRT.

Have you tested with Topaz?

-Scott
