Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFJ1k9yzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:56 +1000 (AEST)
In-Reply-To: <1502630663-18599-1-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <julia.lawall@lip6.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: store the intended structure
Message-Id: <3xXTFH6cfyz9t5T@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-08-13 at 13:24:23 UTC, Julia Lawall wrote:
> Normally the values in the resource field and the argument to ARRAY_SIZE
> in the num_resources are the same.  In this case, the value in the reousrce
> field is the same as the one in the previous platform_device structure, and
> appears to be a copy-paste error.  Replace the value in the resource field
> with the argument to the local call to ARRAY_SIZE.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/36992606eee8016c36ad2576687e97

cheers
