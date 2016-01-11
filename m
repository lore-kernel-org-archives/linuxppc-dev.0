Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDBCA1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:14:01 +1100 (AEDT)
In-Reply-To: <1446008047-2393-1-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [1/2] powerpc: Add function to copy mm_context_t to the paca
Message-Id: <20160111091401.50029140311@ozlabs.org>
Date: Mon, 11 Jan 2016 20:14:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-28-10 at 04:54:06 UTC, Michael Neuling wrote:
> This adds a function to copy the mm->context to the paca.  This is
> only a basic conversion for now but will be used more extensively in
> the next patch.
> 
> This also adds #ifdef CONFIG_PPC_BOOK3S around this code since it's
> not used elsewhere.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c395465da68bfc3a238d5bc15f

cheers
