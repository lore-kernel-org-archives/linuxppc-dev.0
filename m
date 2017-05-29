Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbtRq5cB4zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 20:35:35 +1000 (AEST)
Subject: Re: [PATCH] powerpc/spufs: Fix coredump of SPU contexts
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1496053567-29357-1-git-send-email-mpe@ellerman.id.au>
Cc: viro@zeniv.linux.org.uk
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <f0dba496-ecbf-53b1-590c-066fe102537a@ozlabs.org>
Date: Mon, 29 May 2017 18:35:32 +0800
MIME-Version: 1.0
In-Reply-To: <1496053567-29357-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> So fix it by setting rc = 0 before returning in the success case.
> 
> Fixes: 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Looks good to me, thanks.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
