Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87CCB2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 23:21:55 +1100 (EST)
Subject: Re: [PATCH]powerpc: Corrected include header path in kvm_para.h
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1355829688-32545-1-git-send-email-bharat.bhushan@freescale.com>
Date: Tue, 18 Dec 2012 13:21:45 +0100
Message-Id: <CFBE1325-D80B-4577-A515-8621C37DE7C1@suse.de>
References: <1355829688-32545-1-git-send-email-bharat.bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.12.2012, at 12:21, Bharat Bhushan wrote:

> The include/uapi/asm/kvm_para.h includes
> <include/uapi/asm/epapr_hcalls.h> but the correct reference
> should be <include/asm/epapr_hcalls.h> as this is the place
> where make install_header installs the header files for
> userspace.
>=20
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>

Thanks, applied to kvm-ppc-next (with CC to stable@vger).


Alex

> ---
> arch/powerpc/include/uapi/asm/kvm_para.h |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm_para.h =
b/arch/powerpc/include/uapi/asm/kvm_para.h
> index ed0e025..e3af328 100644
> --- a/arch/powerpc/include/uapi/asm/kvm_para.h
> +++ b/arch/powerpc/include/uapi/asm/kvm_para.h
> @@ -78,7 +78,7 @@ struct kvm_vcpu_arch_shared {
>=20
> #define KVM_HCALL_TOKEN(num)     _EV_HCALL_TOKEN(EV_KVM_VENDOR_ID, =
num)
>=20
> -#include <uapi/asm/epapr_hcalls.h>
> +#include <asm/epapr_hcalls.h>
>=20
> #define KVM_FEATURE_MAGIC_PAGE	1
>=20
> --=20
> 1.7.0.4
>=20
>=20
