Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5BE282C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 06:18:21 +1000 (EST)
Date: Wed, 3 Jul 2013 15:18:12 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/booke64: Add LRAT error exception handler
To: Mihai Caraman <mihai.caraman@freescale.com>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Wed Jul  3 11:56:05 2013)
Message-ID: <1372882692.8183.150@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 11:56:05 AM, Mihai Caraman wrote:
> @@ -1410,6 +1423,7 @@ _GLOBAL(setup_doorbell_ivors)
>  _GLOBAL(setup_ehv_ivors)
>  	SET_IVOR(40, 0x300) /* Embedded Hypervisor System Call */
>  	SET_IVOR(41, 0x320) /* Embedded Hypervisor Privilege */
> +	SET_IVOR(42, 0x340) /* LRAT Error */

What happens if we write to IVOR42 on e5500?  If the answer is no-op, =20
is that behavior guaranteed on any CPU with E.HV but not LRAT?

-Scott=
