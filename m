Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AAE12C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 06:16:37 +1000 (EST)
Date: Wed, 3 Jul 2013 15:16:30 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Add LRAT error exception handler
To: Mihai Caraman <mihai.caraman@freescale.com>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
 <1372870566-11299-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372870566-11299-2-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Wed Jul  3 11:56:06 2013)
Message-ID: <1372882590.8183.149@snotra>
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

On 07/03/2013 11:56:06 AM, Mihai Caraman wrote:
> With LRAT (Logical to Real Address Translation) error exception =20
> handler in kernel
> KVM needs to add the counterpart otherwise will break the build.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/bookehv_interrupts.S |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Please combine these two patches to avoid breaking bisectability.

-Scott=
