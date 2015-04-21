Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C7A21A0205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 06:07:14 +1000 (AEST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4F0CB14007D
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 06:07:12 +1000 (AEST)
Message-ID: <1429646822.4352.112.camel@freescale.com>
Subject: Re: [PATCH] powerpc/defconfig: new way of writing defconfig
From: Scott Wood <scottwood@freescale.com>
To: Lijun Pan <Lijun.Pan@freescale.com>
Date: Tue, 21 Apr 2015 15:07:02 -0500
In-Reply-To: <1429332441-18647-1-git-send-email-Lijun.Pan@freescale.com>
References: <1429332441-18647-1-git-send-email-Lijun.Pan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-17 at 23:47 -0500, Lijun Pan wrote:
> diff --git a/arch/powerpc/configs/kvm_guest.config b/arch/powerpc/configs/kvm_guest.config
> new file mode 100644
> index 0000000..615b0a0
> --- /dev/null
> +++ b/arch/powerpc/configs/kvm_guest.config
> @@ -0,0 +1,2 @@
> +CONFIG_KVM_GUEST=y
> +CONFIG_PPC_QEMU_E500=y
> diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_basic_defconfig
> similarity index 100%
> rename from arch/powerpc/configs/mpc85xx_defconfig
> rename to arch/powerpc/configs/mpc85xx_basic_defconfig

If you're just renaming it then it's not basic.

-Scott
