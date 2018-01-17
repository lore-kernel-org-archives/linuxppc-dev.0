Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Hq20lNzF0XK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:15 +1100 (AEDT)
In-Reply-To: <20180102110324.31978-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jsperbeck@google.com
Subject: Re: selftests/powerpc: Add a test of SEGV error behaviour
Message-Id: <3zM7Hl70krz9t2l@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-02 at 11:03:24 UTC, Michael Ellerman wrote:
> Add a test case of the error code reported when we take a SEGV on a
> mapped but inaccessible area. We broke this recently.
> 
> Based on a test case from John Sperbeck <jsperbeck@google.com>.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: John Sperbeck <jsperbeck@google.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/6ed361586b323e576fd5536078fe9f

cheers
