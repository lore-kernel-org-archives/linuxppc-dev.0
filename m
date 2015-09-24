Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0135.outbound.protection.outlook.com [207.46.100.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C50111A2D68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 08:58:37 +1000 (AEST)
Message-ID: <1443135504.32298.67.camel@freescale.com>
Subject: Re: [PATCH 15/19] KVM: PPC: e500: fix handling local_sid_lookup result
From: Scott Wood <scottwood@freescale.com>
To: Andrzej Hajda <a.hajda@samsung.com>
CC: <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Alexander Graf <agraf@suse.com>, Gleb Natapov <gleb@kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, <kvm-ppc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 24 Sep 2015 17:58:24 -0500
In-Reply-To: <1443103227-25612-16-git-send-email-a.hajda@samsung.com>
References: <1443103227-25612-1-git-send-email-a.hajda@samsung.com>
 <1443103227-25612-16-git-send-email-a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-24 at 16:00 +0200, Andrzej Hajda wrote:
> The function can return negative value.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2046107
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi,
> 
> To avoid problems with too many mail recipients I have sent whole
> patchset only to LKML. Anyway patches have no dependencies.
> 
> Regards
> Andrzej
> ---
>  arch/powerpc/kvm/e500.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
