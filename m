Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDnY4hK0zF10l
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 20:01:21 +1000 (AEST)
In-Reply-To: <20171005234857.2856-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, mauricfo@br.ibm.com, Chris Smart <chris@distroguy.com>,
 Nicholas Piggin <nicholas.piggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: selftests/powerpc: Remove redundant cp_abort test
Message-Id: <40qDnY41NDz9s37@ozlabs.org>
Date: Mon, 21 May 2018 20:01:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-05 at 23:48:57 UTC, Michael Neuling wrote:
> Paste on POWER9 only works on accelerators and no longer on real
> memory. Hence this test is broken so remove it.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/00c946a06ec8414ad22f0e8dcd1718

cheers
