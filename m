Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SV433czF38M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:20:58 +1000 (AEST)
In-Reply-To: <1534775376-22480-2-git-send-email-ldufour@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.ibm.com, npiggin@gmail.com, paulus@samba.org
Subject: Re: [v2,1/3] powerpc/pseries/mm: Introducing FW_FEATURE_BLOCK_REMOVE
Message-Id: <42G3SV13tPz9sCV@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-08-20 at 14:29:34 UTC, Laurent Dufour wrote:
> This feature tells if the hcall H_BLOCK_REMOVE is available.
> 
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5600fbe340331e2a25d1b277f9c190

cheers
