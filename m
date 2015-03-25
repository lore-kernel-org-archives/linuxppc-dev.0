Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B38A1A028E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 12:58:58 +1100 (AEDT)
In-Reply-To: <1425075774-15308-1-git-send-email-yguerrini@tomshardware.fr>
To: Yannick Guerrini <yguerrini@tomshardware.fr>, <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Fix trivial typo in comment
Message-Id: <20150325015858.199E6140119@ozlabs.org>
Date: Wed, 25 Mar 2015 12:58:58 +1100 (AEDT)
Cc: paulus@samba.org, Yannick Guerrini <yguerrini@tomshardware.fr>,
 linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-27-02 at 22:22:54 UTC, Yannick Guerrini wrote:
> Change 'Kenrel' to 'Kernel'
> 
> Signed-off-by: Yannick Guerrini <yguerrini@tomshardware.fr>
> ---
>  arch/powerpc/include/asm/smu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If you're going to send spelling fix patches, please at least fix all the
spelling mistakes in the file at once. I can see several others in this file.

cheers
