Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D95E51A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 11:35:05 +1000 (AEST)
In-Reply-To: <1437584207-20677-1-git-send-email-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org
Subject: Re: powerpc/rtas: Replace magic values with defines
Message-Id: <20150803013505.C7742140E0F@ozlabs.org>
Date: Mon,  3 Aug 2015 11:35:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-22-07 at 16:56:47 UTC, Thomas Huth wrote:
> rtas.h already has some nice #defines for RTAS return status
> codes - let's use them instead of hard-coded "magic" values!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9ef03193a93553885b43

cheers
