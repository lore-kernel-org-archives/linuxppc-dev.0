Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5Gs06HxzDvWg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:15:17 +1100 (AEDT)
In-Reply-To: <1479192976-17847-2-git-send-email-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [powerpc,v6,1/3] Setup AMOR in HV mode
Message-Id: <3tS5Gr4Xtxz9vFs@ozlabs.org>
Date: Mon, 28 Nov 2016 23:15:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-15 at 06:56:14 UTC, Balbir Singh wrote:
> AMOR should be setup in HV mode, we set it up once
> and let the generic kernel handle IAMR. This patch is
> used to enable storage keys in a following patch as
> defined in ISA 3. We don't setup AMOR in DD1, since we
> can't setup IAMR in DD1 (bits have to be 0). If we setup
> AMOR some other code could potentially try to set IAMR
> (guest kernel for example).
> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ee97b6b99f42285d29d439f2e5376e

cheers
