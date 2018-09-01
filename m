Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422TTV6JVQzF39b
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 18:11:42 +1000 (AEST)
From: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 0/6] Ethernet over hdlc
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
Message-ID: <edaf1352-0ef3-f06b-f9ed-662dbf4de3cb@c-s.fr>
Date: Sat, 1 Sep 2018 10:10:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180829131328.27901-1-david.gounaris@infinera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/08/2018 à 15:13, David Gounaris a écrit :
> Here is what has been changed in v2 after the review comments.
> 
> v2-0001: Using UCC_MAX_NUM

This one has a warning/check from checkpatch

> v2-0002: Unchanged
> v2-0003: Changed commit message
> v2-0004: Adding fsl,hmask into the dt instead of changing the default value.
> v2-0005: Unchanged
> v2-0006: Unchanged

All the above have an error from checkpatch

You should run checkpatch on your patches and fix the errors and warnings.

You can also see them at 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=63075

Christophe

> 
> Adding robh+dt@kernel.org for comments regarding dt.
> 
> Best Regards
> David Gounaris
> 
> David Gounaris (6):
>    net/wan/fsl_ucc_hdlc: allow ucc index up to 7
>    net/wan/fsl_ucc_hdlc: allow PARITY_CRC16_PR0_CCITT parity
>    net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
>    net/wan/fsl_ucc_hdlc: hmask
>    net/wan/fsl_ucc_hdlc: GUMR for non tsa mode
>    net/wan/fsl_ucc_hdlc: tx timeout handler
> 
>   .../devicetree/bindings/soc/fsl/cpm_qe/network.txt |  6 +++++
>   drivers/net/wan/fsl_ucc_hdlc.c                     | 28 +++++++++++++++++++---
>   drivers/net/wan/fsl_ucc_hdlc.h                     |  1 +
>   3 files changed, 32 insertions(+), 3 deletions(-)
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
