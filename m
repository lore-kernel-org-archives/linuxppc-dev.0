Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w373C67FSzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:23:03 +1000 (AEST)
Subject: Re: [linuxppc-dev] Patch notification: 1 patch updated
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
References: <20170407121001.12571.87508@ozlabs.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <9424872d-157d-4f87-3422-b84c3a8e47a9@c-s.fr>
Date: Wed, 12 Apr 2017 17:22:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170407121001.12571.87508@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael and Scott,

I see that the status of the below patch has been changed to 'Not 
Applicable' in the linuxppc-dev Patchwork.


About this serie, David S. Miller said:

Sujet : Re: [PATCH 0/2] get rid of immrbar_virt_to_phys()
Date : Wed, 08 Feb 2017 13:17:32 -0500 (EST)
De : David Miller <davem@davemloft.net>
Pour : christophe.leroy@c-s.fr
Copie à : leoli@freescale.com, qiang.zhao@nxp.com, oss@buserror.net, 
linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue,  7 Feb 2017 10:05:07 +0100 (CET)

 > ucc_geth ethernet driver is the only driver using 
immrbar_virt_to_phys() and it uses it incorrectly.
 >
 > This patch fixes ucc_geth driver then removes immrbar_virt_to_phys()

Feel free to merge this via whatever tree handles that SOC fsl driver.

Acked-by: David S. Miller <davem@davemloft.net>




Therefore, who is going to commit this patch ?

Regards
Christophe



Le 07/04/2017 à 14:10, Patchwork a écrit :
> Hello,
>
> The following patch (submitted by you) has been updated in patchwork:
>
>  * linuxppc-dev: [1/2] net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
>      - http://patchwork.ozlabs.org/patch/725043/
>      - for: Linux PPC development
>     was: New
>     now: Not Applicable
>
> This email is a notification only - you do not need to respond.
>
> Happy patchworking.
>
> --
>
> This is an automated mail sent by the patchwork system at
> patchwork.ozlabs.org. To stop receiving these notifications, edit
> your mail settings at:
>   http://patchwork.ozlabs.org/mail/
>
