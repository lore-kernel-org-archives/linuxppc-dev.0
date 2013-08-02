Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 486562C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 16:40:13 +1000 (EST)
Message-ID: <51FB543F.1010402@windriver.com>
Date: Fri, 2 Aug 2013 14:39:59 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH 3/6 v2] kvm: powerpc: allow guest control "G" attribute
 in mas2
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-4-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1375355558-19187-4-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2013 07:12 PM, Bharat Bhushan wrote:
> "G" bit in MAS2 indicates whether the page is Guarded.
> There is no reason to stop guest setting  "E", so allow him.

Could we merge patch 2 and 3 into only one.

Tiejun

>
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v1->v2
>   - no change
>
>   arch/powerpc/kvm/e500.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> index 277cb18..4fd9650 100644
> --- a/arch/powerpc/kvm/e500.h
> +++ b/arch/powerpc/kvm/e500.h
> @@ -117,7 +117,7 @@ static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
>   #define E500_TLB_USER_PERM_MASK (MAS3_UX|MAS3_UR|MAS3_UW)
>   #define E500_TLB_SUPER_PERM_MASK (MAS3_SX|MAS3_SR|MAS3_SW)
>   #define MAS2_ATTRIB_MASK \
> -	  (MAS2_X0 | MAS2_X1 | MAS2_E)
> +	  (MAS2_X0 | MAS2_X1 | MAS2_E | MAS2_G)
>   #define MAS3_ATTRIB_MASK \
>   	  (MAS3_U0 | MAS3_U1 | MAS3_U2 | MAS3_U3 \
>   	   | E500_TLB_USER_PERM_MASK | E500_TLB_SUPER_PERM_MASK)
>
