Return-Path: <kongjianjun@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4FB62C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 01:22:24 +1100 (EST)
Received: by mail-vc0-f179.google.com with SMTP id p1so3399619vcq.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 06:22:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1355233103-14587-1-git-send-email-mihai.caraman@freescale.com>
References: <1355233103-14587-1-git-send-email-mihai.caraman@freescale.com>
Date: Tue, 11 Dec 2012 22:22:21 +0800
Message-ID: <CAFeW=pb9Afawnp7hi6Muzs7HU=TVeKDX4RD6Tw0bMkkY9-TTBw@mail.gmail.com>
Subject: Re: [PATCH] KVM: PPC: Fix SREGS documentation reference
From: Amos Kong <kongjianjun@gmail.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2012 at 9:38 PM, Mihai Caraman
<mihai.caraman@freescale.com> wrote:
>
> Reflect the uapi folder change in SREGS API documentation.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  Documentation/virtual/kvm/api.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index a4df553..9cf591d 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -345,7 +345,7 @@ struct kvm_sregs {
>         __u64 interrupt_bitmap[(KVM_NR_INTERRUPTS + 63) / 64];
>  };
>
> -/* ppc -- see arch/powerpc/include/asm/kvm.h */
> +/* ppc -- see arch/powerpc/include/uapi/asm/kvm.h */

Trivial fix.
Reviewed-by: Amos Kong <kongjianjun@gmail.com>

>
>  interrupt_bitmap is a bitmap of pending external interrupts.  At most
>  one bit may be set.  This interrupt has been acknowledged by the APIC
> --
> 1.7.4.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
