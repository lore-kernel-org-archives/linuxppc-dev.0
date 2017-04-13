Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3dpC03QkzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:28:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Scott Wood <oss@buserror.net>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Subject: Re: [linuxppc-dev] Patch notification: 1 patch updated
In-Reply-To: <9424872d-157d-4f87-3422-b84c3a8e47a9@c-s.fr>
References: <20170407121001.12571.87508@ozlabs.org>
 <9424872d-157d-4f87-3422-b84c3a8e47a9@c-s.fr>
Date: Thu, 13 Apr 2017 21:28:33 +1000
Message-ID: <87tw5s8s2m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Hello Michael and Scott,
>
> I see that the status of the below patch has been changed to 'Not=20
> Applicable' in the linuxppc-dev Patchwork.
>
> About this serie, David S. Miller said:
>
> Sujet : Re: [PATCH 0/2] get rid of immrbar_virt_to_phys()
> Date : Wed, 08 Feb 2017 13:17:32 -0500 (EST)
> De : David Miller <davem@davemloft.net>
> Pour : christophe.leroy@c-s.fr
> Copie =C3=A0 : leoli@freescale.com, qiang.zhao@nxp.com, oss@buserror.net,=
=20
> linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,=20
> netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
>
> From: Christophe Leroy <christophe.leroy@c-s.fr>
> Date: Tue,  7 Feb 2017 10:05:07 +0100 (CET)
>
>  > ucc_geth ethernet driver is the only driver using=20
> immrbar_virt_to_phys() and it uses it incorrectly.
>  >
>  > This patch fixes ucc_geth driver then removes immrbar_virt_to_phys()
>
> Feel free to merge this via whatever tree handles that SOC fsl driver.
>
> Acked-by: David S. Miller <davem@davemloft.net>
>
> Therefore, who is going to commit this patch ?

Sorry my bad, I tend to mark all "net:" patches as not applicable
because Dave nearly always takes them.

But I'll put this back to new and delegate it to Scott.
=20
cheers
