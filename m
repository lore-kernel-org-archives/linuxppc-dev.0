Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1c2sSnzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:36 +1100 (AEDT)
In-Reply-To: <20170113035349.15923-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, benh@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, jk@ozlabs.org
Subject: Re: powerpc: opal-msglog: Report size of memcons log
Message-Id: <3v8g1b3VK2z9t1P@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-13 at 03:53:49 UTC, Joel Stanley wrote:
> The OPAL memory console is reported to be size zero, as we do not
> initialise the struct attr with any size information due to the size
> being variable. This leads users to think that the console is empty.
> 
> Instead report the maximum size.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/14a41d6b7572026cf8fc88ee72e81b

cheers
